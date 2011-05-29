import cgi
import urllib
from google.appengine.ext import webapp
from google.appengine.ext.webapp.util import run_wsgi_app
from google.appengine.ext import db

class Service(db.Model):
  name = db.StringProperty(multiline=False)
  url = db.StringProperty(multiline=False)
  
class MainPage(webapp.RequestHandler):
  def get(self):

     if self.request.get('type')=='add':  # Adding a new service to the DNS (You can also use Update but it won't tell you the service already exists)
          param2=self.request.get('name') #the Name the service will be known by         
          param3=self.request.get('url') # the URL for the web service
          q = db.GqlQuery("SELECT * FROM Service WHERE name = :kk",kk=param2)
          count=q.count(2)

          if count==0 :  # the service doesn't exist, so add it.
              if param2=="" or param3=="" :
                  self.response.out.write('Error2')
              else:
                  newrec=Service(name=param2,url=param3)
                  newrec.put()
                  self.response.out.write('Added')
          else:
              self.response.out.write('Found')  # service already exists so announce that and do nothing
              
     elif self.request.get('type')=='remove': #removing a service
          param2=self.request.get('name')	 # the name the service is known by
          q = db.GqlQuery("SELECT * FROM Service WHERE name = :kk",kk=param2)
          count=q.count(2)

          if count==0 :
            self.response.out.write('None') # Service wasn't found
          else:
            results=q.fetch(10)            
            db.delete(results)  # remove them all (just in case some how, some way, there is more than one service with the same name 
            self.response.out.write('Removed')
            
     elif self.request.get('type')=='update':  # update an existing service. Note this creates a new service, or updates an existing one
          param2=self.request.get('name') #the Name the service will be known by         
          param3=self.request.get('url') # the URL for the web service
          q = db.GqlQuery("SELECT * FROM Service WHERE name = :kk",kk=param2)
          count=q.count(2)

          if count!=0 :  # if record already exists, remove it
                results=q.fetch(10)            
                db.delete(results)  # remove them all (just in case some how, some way, there is more than one service with the same name
          if param2=="" or param3=="" :
              self.response.out.write('Error2')
          else:
              newrec=Service(name=param2,url=param3) # add record, either replacing the deleted one, or adding a new one if it never existed
              newrec.put()
              if count!=0 : 
                  self.response.out.write('Updated')
              else:
                  self.response.out.write('Added')
            
     elif self.request.get('type')=='retrieve': # get the current URL for a given service
          param2=self.request.get('name')	 # the name the service is known by
          q = db.GqlQuery("SELECT * FROM Service WHERE name = :kk",kk=param2)
          count=q.count(2)
          if count==0 :
                self.response.out.write('None') # Service wasn't found
          else:
                record=q.get()
                self.response.out.write(record.url) #print the URL
     elif self.request.get('type')=='list': # List the existing services
          q = db.GqlQuery("SELECT * FROM Service" )
          count=q.count()

          if count==0 :
              self.response.out.write('Empty') # Services weren't found
          else: 
              results = q.fetch(1000)
              for result in results:      
                 self.response.out.write(result.name+','+result.url+" ")
              self.response.out.write('END')  # Cap the list             
 
     else: self.response.out.write('Error')

class Redirector(webapp.RequestHandler):
  def get(self):
    service_name=self.request.path
    if service_name[-1]=='/' :
      service_name=service_name[1:-1] #remove leading and trailing slash
    else:
      service_name=service_name[1:]  # remove leading slash only
    i=service_name.find("/")
    lastpath=''
    if(i>=0):
       lastpath=service_name[i+1:]
       service_name=service_name[0:i]
      
    #un-escape just in case you're Kinki :p
    service_name=urllib.unquote(service_name)
    #self.response.out.write("#"+service_name+"#:"+lastpath)

  
    q = db.GqlQuery("SELECT * FROM Service WHERE name = :kk",kk=service_name)
    count=q.count(2)
    if count==0 :
      self.response.out.write('None') # Service wasn't found
    else:
      record=q.get()  #get the URL we stored previously

      if self.request.query_string != '' :
        self.redirect(urllib.unquote(record.url)+"/"+lastpath+'?'+self.request.query_string) # redirect to the HTTP-IN URL with arugments
      else:        
        self.redirect(urllib.unquote(record.url)+"/"+lastpath) # redirect to the HTTP-IN URL
      
application = webapp.WSGIApplication(
                                     [('/', MainPage),
                                      ('/.*',Redirector)],
                                     debug=True)

def main():
  run_wsgi_app(application)

if __name__ == "__main__":
  main()