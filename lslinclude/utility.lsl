#ifndef TSTAMP
#define TSTAMP
string tstamp() {
    string s=llGetTimestamp();
    return llGetSubString(s,0,9)+" "+llGetSubString(s,11,22);
}
#endif

string parseParams(integer n)
{
    return llList2String(llParseStringKeepNulls(llGetObjectDesc(),["-"],[]),n);
    
}
// Returns a new string replacing all instances of old with new starting at pos in source.
// A pos of 0 would begin replacing old with new at the beginning of source.
// A pos of 10 would begin replacing old with new at the 10th character of source.
string StringReplace(integer pos, string source, string old, string new)
{
    string str = source;
    string pre = "";
    if (pos > 0)
    {
        pre = llGetSubString(source, 0, pos - 1);
        str = llGetSubString(source, pos, -1);
    }
    integer len = llStringLength(old);
    integer index = llSubStringIndex(str, old);
    while (index > -1)
    {
        str = llInsertString(llDeleteSubString(str, index, index + len - 1), index, new);
        index = llSubStringIndex(str, old);
    }
    return pre + str;
}

integer startswith(string haystack, string needle) // http://wiki.secondlife.com/wiki/llSubStringIndex
{
    return llDeleteSubString(haystack, llStringLength(needle), -1) == needle;
}

#define ISNOTOWNER(id) L2K(llGetObjectDetails(id,[ OBJECT_OWNER ]),0) != llGetOwner()


