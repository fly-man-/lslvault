// MiniWave
// A way to relay chat between virtual worlds. How to use it
// You must rez an object with the RELAY.lsl script
// You need to have a working Skype with an intermediate user running
// You also need to know the skype id of the chat you want to relay
// This program is opensource, GPL v3.
// 2012 Salahzar Stenvaag 
// Program is born from an original idea Junta Kohime

using System.Net;
using System.Web;
using System;
using System.Collections.Generic;
using System.IO;
using SKYPE4COMLib;
using System.Threading; // to bind to Skype
class Program
{

    static Skype skype;
    static IChat chat;
    static Dictionary<String, String> waves = new Dictionary<String, String>();
    // static string chatname = "#zogia.zabelin/$66f16fef24c21c1";
    static string chatname = "#pyramidosita/$salahzar.stenvaag;f271358ebb66aa91";
    static void Main(string[] args)
    {
        //rootDirectory = args[0]; 
        skype = new Skype(); // New Skype Class


        if (skype.Client.IsRunning != true) // If Skype Client is not running, then start it
            skype.Client.Start(true, true); // Start Skype Client

        skype.MessageStatus += new _ISkypeEvents_MessageStatusEventHandler(skype_MessageStatus);
        skype.Attach(7, false);
        chat = skype.get_Chat(chatname);
        waves.Add("SKYPE", "SKYPE");

        HttpListener listener = new HttpListener();
        listener.Prefixes.Add("http://*:8080/");

        for (int k = 1; k < args.Length; k++)
            listener.Prefixes.Add(args[k]);
        listener.Start();
        while (true)
        {
            HttpListenerContext context = listener.GetContext();
            Process(context);
        }
    }
    static void skype_MessageStatus(ChatMessage pMessage, TChatMessageStatus Status)
    {
        // Console.Write("Status: " + Status.ToString());
        Console.Write("FromDisplayName: " + pMessage.FromDisplayName + " ChatName: " + pMessage.ChatName + " Body:" + pMessage.Body + " Status: " + Status + "\n");
        if (Status != TChatMessageStatus.cmsReceived)
            return;
        Console.Write("Sending " + pMessage.Body + " to clients\n");
        Send("SKYPE", pMessage.FromDisplayName + ":" + pMessage.Body);
    }

    private static void Send(string sender, string message)
    {
        if (message == null) return;
        foreach (String s in waves.Keys)
        {
            if (s != sender)
            {
                if (s == "SKYPE")
                {
                    // send to skype
                    Console.WriteLine("Sending " + message + " to skype");
                    chat.SendMessage("[miniwave]" + message);
                }
                else
                {
                    // using multithreading to avoid blocking of main thread if some object is not answering in time
                    Console.WriteLine("Creating new thread for Sending " + message + " to url " + s);
                    Worker w = new Worker();
                    w.message = message;
                    w.s = s;
                    Thread workerThread = new Thread(w.DoWork);

                    // Start the worker thread.
                    workerThread.Start();
                }
            }
        }

    }

    private static void Process(HttpListenerContext context)
    {
        try
        {
            string type = context.Request.QueryString["type"];
            string sender = context.Request.QueryString["sender"];
            string message = context.Request.QueryString["message"];
            if (sender == null) goto Return;
            if (!waves.ContainsKey(sender))
            {
                waves.Add(sender, sender);
                Console.WriteLine("Added sender " + sender);

            }
            if (type != null && type.Equals("remove"))
            {
                waves.Remove(sender);
                Console.WriteLine("Removed sender " + sender);
                goto Return;
            }

            Send(sender, message);



        }
        catch (Exception ex)
        {

            Console.WriteLine(ex);
        }
    Return:
        Console.WriteLine(context.Request.Url.Query.Normalize());
        System.Text.ASCIIEncoding encoding = new System.Text.ASCIIEncoding();
        context.Response.OutputStream.Write(encoding.GetBytes("Processed \n"), 0, 9);

        context.Response.OutputStream.Close();
    }
    public class Worker
    {
        public string message;
        public string s;
        // This method will be called when the thread is started.
        public void DoWork()
        {
            Console.WriteLine("Starting thread for sending a message \n");
            var request = (HttpWebRequest)WebRequest.Create(s + "/?message=" + HttpUtility.UrlEncode(message));
            // request.Referer = "http://www.youtube.com/"; // optional
            request.UserAgent =
                "Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.0; WOW64; " +
                "Trident/4.0; SLCC1; .NET CLR 2.0.50727; Media Center PC 5.0; " +
                ".NET CLR 3.5.21022; .NET CLR 3.5.30729; .NET CLR 3.0.30618; " +
                "InfoPath.2; OfficeLiveConnector.1.3; OfficeLivePatch.0.0)";
            try
            {
                var response = (HttpWebResponse)request.GetResponse();
                using (var reader = new StreamReader(response.GetResponseStream()))
                {
                    var html = reader.ReadToEnd();
                }
            }
            catch (WebException ex)
            {
                Console.WriteLine(ex);
                waves.Remove(s);
            }
            Console.WriteLine("Ending thread\n");
        }
        public void RequestStop()
        {
            _shouldStop = true;
        }
        // Volatile is used as hint to the compiler that this data
        // member will be accessed by multiple threads.
        private volatile bool _shouldStop;
    }
}
