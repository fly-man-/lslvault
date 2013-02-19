string hexc="0123456789ABCDEF";//faster

string Float2Hex(float input)
{// Copyright Strife Onizuka, 2006, LGPL, http://www.gnu.org/copyleft/lesser.html
    if((integer)input != input)//LL screwed up hex integers support in rotation & vector string typecasting
    {//this also keeps zero from hanging the zero stripper.
        float unsigned = llFabs(input);//logs don't work on negatives.
        integer exponent = llFloor(llLog(unsigned) / 0.69314718055994530941723212145818);//floor(log2(b))
        if(exponent > 127) exponent = 127;//catch fatal rounding error in exponent.
        integer mantissa = (integer)((unsigned / (float)("0x1p"+(string)exponent)) * 0x1000000);//shift up into integer range
        while(!(mantissa & 0x1))
        {//strip extra zeros off before converting or they break "p"
            mantissa = mantissa >> 1;
            exponent = -~exponent;//++c;
        }
        string str = "p" + (string)(exponent - 24);
        do
            str = llGetSubString(hexc,15&mantissa,15&mantissa) + str;
        while(mantissa = mantissa >> 4);
        if(input < 0)
            return "-0x" + str;
        return "0x" + str;
    }//integers pack well so anything that qualifies as an integer we dump as such, supports netative zero
    return llDeleteSubString((string)input,-7,-1);//trim off the float portion, return an integer
}

string Vec2Hex(vector a)
{
    return "<"+Float2Hex(a.x)+","+Float2Hex(a.y)+","+Float2Hex(a.z)+">";
}

