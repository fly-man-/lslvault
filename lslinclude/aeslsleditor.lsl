integer lslAESStateX3Y3         = 0;
integer lslAESStateX3Y2         = 0;
integer lslAESStateX3Y1         = 0;
integer lslAESStateX3Y0         = 0;
integer lslAESStateX2Y3         = 0;
integer lslAESStateX2Y2         = 0;
integer lslAESStateX2Y1         = 0;
integer lslAESStateX2Y0         = 0;
integer lslAESStateX1Y3         = 0;
integer lslAESStateX1Y2         = 0;
integer lslAESStateX1Y1         = 0;
integer lslAESStateX1Y0         = 0;
integer lslAESStateX0Y3         = 0;
integer lslAESStateX0Y2         = 0;
integer lslAESStateX0Y1         = 0;
integer lslAESStateX0Y0         = 0;
integer lslAESRounds            = 0;
list lslAESRoundKey          = [];
integer lslAESPadSize           = 512;
integer lslAESPad               = 1;
integer lslAESMode              = 1;
integer lslAESInputVector3      = 0;
integer lslAESInputVector2      = 0;
integer lslAESInputVector1      = 0;
integer lslAESInputVector0      = 0;
integer LSLAES_PAD_ZEROES       = 5;
integer LSLAES_PAD_RANDOM       = 4;
integer LSLAES_PAD_NULLS_SAFE = 3;
integer LSLAES_PAD_NULLS        = 2;
integer LSLAES_PAD_NONE            = 0;
list LSLAES_PADS             = [
    "PAD_NONE",        LSLAES_PAD_NONE,
    "PAD_RBT",         1,
    "PAD_NULLS",       LSLAES_PAD_NULLS,
    "PAD_NULLS_SAFE", LSLAES_PAD_NULLS_SAFE,
    "PAD_RANDOM",      LSLAES_PAD_RANDOM,
    "PAD_ZEROES",      LSLAES_PAD_ZEROES
];
integer LSLAES_OUTPUT_TYPE_MASK = 0x00000F00;
integer LSLAES_OUTPUT_HEX       = 0x00000000;
integer LSLAES_OUTPUT_BASE64    = 0x00000100;
integer LSLAES_MODE_CFB         = 2;
list LSLAES_MODES            = [
    "MODE_CBC",     1,
    "MODE_CFB",     LSLAES_MODE_CFB
];
integer LSLAES_MAX_SIZE         = 1664;
integer LSLAES_INPUT_TYPE_MASK  = 0x0000F000;
integer LSLAES_INPUT_HEX        = 0x00000000;
integer LSLAES_INPUT_BASE64     = 0x00001000;
string LSLAES_HEX_CHARS        = "0123456789abcdef";
integer LSLAES_FILTER_REQUEST   = 0x81000000;
integer LSLAES_FILTER_REPLY     = 0x82000000;
integer LSLAES_FILTER_MASK      = 0xFF000000;
integer LSLAES_COMMAND_SETUP    = 0x00050000;
integer LSLAES_COMMAND_PRIME    = 0x00010000;
integer LSLAES_COMMAND_MASK     = 0x00FF0000;
integer LSLAES_COMMAND_INIT     = 0x00060000;
integer LSLAES_COMMAND_ERROR    = 0x00000000;
integer LSLAES_COMMAND_ENCRYPT  = 0x00020000;
integer LSLAES_COMMAND_DECRYPT  = 0x00030000;
string LSLAES_BASE64_CHARS     = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

 

lslAESMixColumns() {    
    integer t = lslAESStateX0Y0;
    integer t1 = lslAESStateX0Y0 ^ lslAESStateX0Y1 ^ 
        lslAESStateX0Y2 ^ lslAESStateX0Y3;
 
    integer t2 = lslAESXTimes(lslAESStateX0Y0 ^ lslAESStateX0Y1);
    lslAESStateX0Y0 = lslAESStateX0Y0 ^ t2 ^ t1;
 
    t2 = lslAESXTimes(lslAESStateX0Y1 ^ lslAESStateX0Y2);
    lslAESStateX0Y1 = lslAESStateX0Y1 ^ t2 ^ t1;
 
    t2 = lslAESXTimes(lslAESStateX0Y2 ^ lslAESStateX0Y3);
    lslAESStateX0Y2 = lslAESStateX0Y2 ^ t2 ^ t1;
 
    t2 = lslAESXTimes(lslAESStateX0Y3 ^ t);
    lslAESStateX0Y3 = lslAESStateX0Y3 ^ t2 ^ t1;
 
    t = lslAESStateX1Y0;
    t1 = lslAESStateX1Y0 ^ lslAESStateX1Y1 ^ lslAESStateX1Y2 ^ lslAESStateX1Y3;
 
    t2 = lslAESXTimes(lslAESStateX1Y0 ^ lslAESStateX1Y1);
    lslAESStateX1Y0 = lslAESStateX1Y0 ^ t2 ^ t1;
 
    t2 = lslAESXTimes(lslAESStateX1Y1 ^ lslAESStateX1Y2);
    lslAESStateX1Y1 = lslAESStateX1Y1 ^ t2 ^ t1;
 
    t2 = lslAESXTimes(lslAESStateX1Y2 ^ lslAESStateX1Y3);
    lslAESStateX1Y2 = lslAESStateX1Y2 ^ t2 ^ t1;
 
    t2 = lslAESXTimes(lslAESStateX1Y3 ^ t);
    lslAESStateX1Y3 = lslAESStateX1Y3 ^ t2 ^ t1;
 
    t = lslAESStateX2Y0;
    t1 = lslAESStateX2Y0 ^ lslAESStateX2Y1 ^ lslAESStateX2Y2 ^ lslAESStateX2Y3;
 
    t2 = lslAESXTimes(lslAESStateX2Y0 ^ lslAESStateX2Y1);
    lslAESStateX2Y0 = lslAESStateX2Y0 ^ t2 ^ t1;
 
    t2 = lslAESXTimes(lslAESStateX2Y1 ^ lslAESStateX2Y2);
    lslAESStateX2Y1 = lslAESStateX2Y1 ^ t2 ^ t1;
 
    t2 = lslAESXTimes(lslAESStateX2Y2 ^ lslAESStateX2Y3);
    lslAESStateX2Y2 = lslAESStateX2Y2 ^ t2 ^ t1;
 
    t2 = lslAESXTimes(lslAESStateX2Y3 ^ t);
    lslAESStateX2Y3 = lslAESStateX2Y3 ^ t2 ^ t1;
 
    t = lslAESStateX3Y0;
    t1 = lslAESStateX3Y0 ^ lslAESStateX3Y1 ^ lslAESStateX3Y2 ^ lslAESStateX3Y3;
 
    t2 = lslAESXTimes(lslAESStateX3Y0 ^ lslAESStateX3Y1);
    lslAESStateX3Y0 = lslAESStateX3Y0 ^ t2 ^ t1;
 
    t2 = lslAESXTimes(lslAESStateX3Y1 ^ lslAESStateX3Y2);
    lslAESStateX3Y1 = lslAESStateX3Y1 ^ t2 ^ t1;
 
    t2 = lslAESXTimes(lslAESStateX3Y2 ^ lslAESStateX3Y3);
    lslAESStateX3Y2 = lslAESStateX3Y2 ^ t2 ^ t1;
 
    t2 = lslAESXTimes(lslAESStateX3Y3 ^ t);
    lslAESStateX3Y3 = lslAESStateX3Y3 ^ t2 ^ t1;
}
integer lslAESInverseAffine(integer x) {
    x = (x << 1) ^ (x << 3) ^ (x << 6);
    return 0x05 ^ ((x ^ (x >> 8)) & 0xFF);
}
integer lslAESHibit(integer x) {
    x = (x >> 1) | (x >> 2);
    x = x | (x >> 2);
    x = x | (x >> 4);
    return (++x) >> 1;
}
integer lslAESGetSBoxInvertedByte(integer n) {    
    return lslAESMultInverse(lslAESInverseAffine(n));
}
integer lslAESAffine(integer x) {
    x = x ^ (x << 1) ^ (x << 2) ^ (x << 3) ^ (x << 4);
    return 0x63 ^ ((x ^ (x >> 8)) & 0xFF);
}

 







lslAESAddRoundKey(integer round) {
    round = round << 2;
 
    integer t = llList2Integer(lslAESRoundKey, round);
    lslAESStateX0Y0 = lslAESStateX0Y0 ^ ((t >> 24) & 0xFF);
    lslAESStateX0Y1 = lslAESStateX0Y1 ^ ((t >> 16) & 0xFF);
    lslAESStateX0Y2 = lslAESStateX0Y2 ^ ((t >> 8 ) & 0xFF);
    lslAESStateX0Y3 = lslAESStateX0Y3 ^ ((t      ) & 0xFF);
 
    t = llList2Integer(lslAESRoundKey, ++round);
    lslAESStateX1Y0 = lslAESStateX1Y0 ^ ((t >> 24) & 0xFF);
    lslAESStateX1Y1 = lslAESStateX1Y1 ^ ((t >> 16) & 0xFF);
    lslAESStateX1Y2 = lslAESStateX1Y2 ^ ((t >> 8 ) & 0xFF);
    lslAESStateX1Y3 = lslAESStateX1Y3 ^ ((t      ) & 0xFF);
 
    t = llList2Integer(lslAESRoundKey, ++round);
    lslAESStateX2Y0 = lslAESStateX2Y0 ^ ((t >> 24) & 0xFF);
    lslAESStateX2Y1 = lslAESStateX2Y1 ^ ((t >> 16) & 0xFF);
    lslAESStateX2Y2 = lslAESStateX2Y2 ^ ((t >> 8 ) & 0xFF);
    lslAESStateX2Y3 = lslAESStateX2Y3 ^ ((t      ) & 0xFF);
 
    t = llList2Integer(lslAESRoundKey, ++round);
    lslAESStateX3Y0 = lslAESStateX3Y0 ^ ((t >> 24) & 0xFF);
    lslAESStateX3Y1 = lslAESStateX3Y1 ^ ((t >> 16) & 0xFF);
    lslAESStateX3Y2 = lslAESStateX3Y2 ^ ((t >> 8 ) & 0xFF);
    lslAESStateX3Y3 = lslAESStateX3Y3 ^ ((t      ) & 0xFF);
}
integer lslAESXTimes(integer x) {
    return ((x << 1) ^ (((x >> 7) & 1) * 0x1b)) & 0xFF;
}

 

lslAESSubBytes() {
    lslAESStateX0Y0 = lslAESGetSBoxByte(lslAESStateX0Y0);
    lslAESStateX0Y1 = lslAESGetSBoxByte(lslAESStateX0Y1);
    lslAESStateX0Y2 = lslAESGetSBoxByte(lslAESStateX0Y2);
    lslAESStateX0Y3 = lslAESGetSBoxByte(lslAESStateX0Y3);
    lslAESStateX1Y0 = lslAESGetSBoxByte(lslAESStateX1Y0);
    lslAESStateX1Y1 = lslAESGetSBoxByte(lslAESStateX1Y1);
    lslAESStateX1Y2 = lslAESGetSBoxByte(lslAESStateX1Y2);
    lslAESStateX1Y3 = lslAESGetSBoxByte(lslAESStateX1Y3);
    lslAESStateX2Y0 = lslAESGetSBoxByte(lslAESStateX2Y0);
    lslAESStateX2Y1 = lslAESGetSBoxByte(lslAESStateX2Y1);
    lslAESStateX2Y2 = lslAESGetSBoxByte(lslAESStateX2Y2);
    lslAESStateX2Y3 = lslAESGetSBoxByte(lslAESStateX2Y3);
    lslAESStateX3Y0 = lslAESGetSBoxByte(lslAESStateX3Y0);
    lslAESStateX3Y1 = lslAESGetSBoxByte(lslAESStateX3Y1);
    lslAESStateX3Y2 = lslAESGetSBoxByte(lslAESStateX3Y2);
    lslAESStateX3Y3 = lslAESGetSBoxByte(lslAESStateX3Y3);
}

 
 

lslAESShiftRows() { 
    
    integer t = lslAESStateX0Y1;
    lslAESStateX0Y1 = lslAESStateX1Y1;
    lslAESStateX1Y1 = lslAESStateX2Y1;
    lslAESStateX2Y1 = lslAESStateX3Y1;
    lslAESStateX3Y1 = t;
 
    
    t = lslAESStateX0Y2;
    lslAESStateX0Y2 = lslAESStateX2Y2;
    lslAESStateX2Y2 = t;
 
    t = lslAESStateX1Y2;
    lslAESStateX1Y2 = lslAESStateX3Y2;
    lslAESStateX3Y2 = t;
 
    
    t = lslAESStateX0Y3;
    lslAESStateX0Y3 = lslAESStateX3Y3;
    lslAESStateX3Y3 = lslAESStateX2Y3;
    lslAESStateX2Y3 = lslAESStateX1Y3;
    lslAESStateX1Y3 = t;
}

 







 


 




 




 



lslAESPerformCipher() {
    lslAESAddRoundKey(0);
 
    
    
    integer j = 1;
    while (j < lslAESRounds) {
        lslAESSubBytes();
        lslAESShiftRows();
        lslAESMixColumns();
        lslAESAddRoundKey(j++);
    }
 
    
    lslAESSubBytes();
    lslAESShiftRows();
    lslAESAddRoundKey(lslAESRounds);
}
integer lslAESMultiply(integer x, integer y) {
    integer xT  = lslAESXTimes(x);
    integer xT2 = lslAESXTimes(xT);
    integer xT3 = lslAESXTimes(xT2);
 
    return (((y & 1) * x) ^ (((y >> 1) & 1) * xT) ^ 
            (((y >> 2) & 1) * xT2) ^ (((y >> 3) & 1) * xT3) ^ 
            (((y >> 4) & 1) * lslAESXTimes(xT3))) & 0xFF;
}
integer lslAESMultInverse(integer p1) {
    if(p1 < 2) return p1;
 
    integer p2 = 0x1b;
    integer n1 = lslAESHibit(p1);
    integer n2 = 0x80;
    integer v1 = 1;
    integer v2 = 0;
 
    do {
        if(n1)
            while(n2 >= n1) {                 
                n2 /= n1;                     
                p2 = p2 ^ ((p1 * n2) & 0xFF); 
                v2 = v2 ^ ((v1 * n2) & 0xFF); 
                n2 = lslAESHibit(p2);               
            }
        else return v1;
 
        if(n2)                                
            while(n1 >= n2) {
                n1 /= n2;
                p1 = p1 ^ ((p2 * n1) & 0xFF);
                v1 = v1 ^ ((v2 * n1) & 0xFF);
                n1 = lslAESHibit(p1);
            }
        else return v2;
    } while (TRUE);
    return 0;
}

 

lslAESLoadInputVector() {
    lslAESStateX0Y0 = (lslAESInputVector0 >> 24) & 0xFF;
    lslAESStateX0Y1 = (lslAESInputVector0 >> 16) & 0xFF;
    lslAESStateX0Y2 = (lslAESInputVector0 >> 8 ) & 0xFF;
    lslAESStateX0Y3 = (lslAESInputVector0      ) & 0xFF;
 
    lslAESStateX1Y0 = (lslAESInputVector1 >> 24) & 0xFF;
    lslAESStateX1Y1 = (lslAESInputVector1 >> 16) & 0xFF;
    lslAESStateX1Y2 = (lslAESInputVector1 >> 8 ) & 0xFF;
    lslAESStateX1Y3 = (lslAESInputVector1      ) & 0xFF;
 
    lslAESStateX2Y0 = (lslAESInputVector2 >> 24) & 0xFF;
    lslAESStateX2Y1 = (lslAESInputVector2 >> 16) & 0xFF;
    lslAESStateX2Y2 = (lslAESInputVector2 >> 8 ) & 0xFF;
    lslAESStateX2Y3 = (lslAESInputVector2      ) & 0xFF;
 
    lslAESStateX3Y0 = (lslAESInputVector3 >> 24) & 0xFF;
    lslAESStateX3Y1 = (lslAESInputVector3 >> 16) & 0xFF;
    lslAESStateX3Y2 = (lslAESInputVector3 >> 8 ) & 0xFF;
    lslAESStateX3Y3 = (lslAESInputVector3      ) & 0xFF;
}

 

lslAESInvertSubBytes() {
    lslAESStateX0Y0 = lslAESGetSBoxInvertedByte(lslAESStateX0Y0);
    lslAESStateX0Y1 = lslAESGetSBoxInvertedByte(lslAESStateX0Y1);
    lslAESStateX0Y2 = lslAESGetSBoxInvertedByte(lslAESStateX0Y2);
    lslAESStateX0Y3 = lslAESGetSBoxInvertedByte(lslAESStateX0Y3);
    lslAESStateX1Y0 = lslAESGetSBoxInvertedByte(lslAESStateX1Y0);
    lslAESStateX1Y1 = lslAESGetSBoxInvertedByte(lslAESStateX1Y1);
    lslAESStateX1Y2 = lslAESGetSBoxInvertedByte(lslAESStateX1Y2);
    lslAESStateX1Y3 = lslAESGetSBoxInvertedByte(lslAESStateX1Y3);
    lslAESStateX2Y0 = lslAESGetSBoxInvertedByte(lslAESStateX2Y0);
    lslAESStateX2Y1 = lslAESGetSBoxInvertedByte(lslAESStateX2Y1);
    lslAESStateX2Y2 = lslAESGetSBoxInvertedByte(lslAESStateX2Y2);
    lslAESStateX2Y3 = lslAESGetSBoxInvertedByte(lslAESStateX2Y3);
    lslAESStateX3Y0 = lslAESGetSBoxInvertedByte(lslAESStateX3Y0);
    lslAESStateX3Y1 = lslAESGetSBoxInvertedByte(lslAESStateX3Y1);
    lslAESStateX3Y2 = lslAESGetSBoxInvertedByte(lslAESStateX3Y2);
    lslAESStateX3Y3 = lslAESGetSBoxInvertedByte(lslAESStateX3Y3);
}

 

lslAESInvertShiftRows() { 
    
    integer t = lslAESStateX3Y1;
    lslAESStateX3Y1 = lslAESStateX2Y1;
    lslAESStateX2Y1 = lslAESStateX1Y1;
    lslAESStateX1Y1 = lslAESStateX0Y1;
    lslAESStateX0Y1 = t;
 
    
    t = lslAESStateX0Y2;
    lslAESStateX0Y2 = lslAESStateX2Y2;
    lslAESStateX2Y2 = t;
 
    t = lslAESStateX1Y2;
    lslAESStateX1Y2 = lslAESStateX3Y2;
    lslAESStateX3Y2 = t;
 
    
    t = lslAESStateX0Y3;
    lslAESStateX0Y3 = lslAESStateX1Y3;
    lslAESStateX1Y3 = lslAESStateX2Y3;
    lslAESStateX2Y3 = lslAESStateX3Y3;
    lslAESStateX3Y3 = t;
}

 


 


 

lslAESInvertMixColumns() {
    integer a = lslAESStateX0Y0;
    integer b = lslAESStateX0Y1;
    integer c = lslAESStateX0Y2;
    integer d = lslAESStateX0Y3;
 
    lslAESStateX0Y0 = lslAESMultiply(a, 0x0e) ^ lslAESMultiply(b, 0x0b) ^ 
        lslAESMultiply(c, 0x0d) ^ lslAESMultiply(d, 0x09);
    lslAESStateX0Y1 = lslAESMultiply(a, 0x09) ^ lslAESMultiply(b, 0x0e) ^ 
        lslAESMultiply(c, 0x0b) ^ lslAESMultiply(d, 0x0d);
    lslAESStateX0Y2 = lslAESMultiply(a, 0x0d) ^ lslAESMultiply(b, 0x09) ^ 
        lslAESMultiply(c, 0x0e) ^ lslAESMultiply(d, 0x0b);
    lslAESStateX0Y3 = lslAESMultiply(a, 0x0b) ^ lslAESMultiply(b, 0x0d) ^ 
        lslAESMultiply(c, 0x09) ^ lslAESMultiply(d, 0x0e);
 
    a = lslAESStateX1Y0;
    b = lslAESStateX1Y1;
    c = lslAESStateX1Y2;
    d = lslAESStateX1Y3;
 
    lslAESStateX1Y0 = lslAESMultiply(a, 0x0e) ^ lslAESMultiply(b, 0x0b) ^ 
        lslAESMultiply(c, 0x0d) ^ lslAESMultiply(d, 0x09);
    lslAESStateX1Y1 = lslAESMultiply(a, 0x09) ^ lslAESMultiply(b, 0x0e) ^ 
        lslAESMultiply(c, 0x0b) ^ lslAESMultiply(d, 0x0d);
    lslAESStateX1Y2 = lslAESMultiply(a, 0x0d) ^ lslAESMultiply(b, 0x09) ^ 
        lslAESMultiply(c, 0x0e) ^ lslAESMultiply(d, 0x0b);
    lslAESStateX1Y3 = lslAESMultiply(a, 0x0b) ^ lslAESMultiply(b, 0x0d) ^ 
        lslAESMultiply(c, 0x09) ^ lslAESMultiply(d, 0x0e);
 
    a = lslAESStateX2Y0;
    b = lslAESStateX2Y1;
    c = lslAESStateX2Y2;
    d = lslAESStateX2Y3;
 
    lslAESStateX2Y0 = lslAESMultiply(a, 0x0e) ^ lslAESMultiply(b, 0x0b) ^ 
        lslAESMultiply(c, 0x0d) ^ lslAESMultiply(d, 0x09);
    lslAESStateX2Y1 = lslAESMultiply(a, 0x09) ^ lslAESMultiply(b, 0x0e) ^ 
        lslAESMultiply(c, 0x0b) ^ lslAESMultiply(d, 0x0d);
    lslAESStateX2Y2 = lslAESMultiply(a, 0x0d) ^ lslAESMultiply(b, 0x09) ^ 
        lslAESMultiply(c, 0x0e) ^ lslAESMultiply(d, 0x0b);
    lslAESStateX2Y3 = lslAESMultiply(a, 0x0b) ^ lslAESMultiply(b, 0x0d) ^ 
        lslAESMultiply(c, 0x09) ^ lslAESMultiply(d, 0x0e);
 
    a = lslAESStateX3Y0;
    b = lslAESStateX3Y1;
    c = lslAESStateX3Y2;
    d = lslAESStateX3Y3;
 
    lslAESStateX3Y0 = lslAESMultiply(a, 0x0e) ^ lslAESMultiply(b, 0x0b) ^ 
        lslAESMultiply(c, 0x0d) ^ lslAESMultiply(d, 0x09);
    lslAESStateX3Y1 = lslAESMultiply(a, 0x09) ^ lslAESMultiply(b, 0x0e) ^ 
        lslAESMultiply(c, 0x0b) ^ lslAESMultiply(d, 0x0d);
    lslAESStateX3Y2 = lslAESMultiply(a, 0x0d) ^ lslAESMultiply(b, 0x09) ^ 
        lslAESMultiply(c, 0x0e) ^ lslAESMultiply(d, 0x0b);
    lslAESStateX3Y3 = lslAESMultiply(a, 0x0b) ^ lslAESMultiply(b, 0x0d) ^ 
        lslAESMultiply(c, 0x09) ^ lslAESMultiply(d, 0x0e);
}
list lslAESInvertCipher(list data) {
    
    integer prevBlock0 = lslAESInputVector0;
    integer prevBlock1 = lslAESInputVector1;
    integer prevBlock2 = lslAESInputVector2;
    integer prevBlock3 = lslAESInputVector3;
 
    integer nextBlock0 = 0;
    integer nextBlock1 = 0;
    integer nextBlock2 = 0;
    integer nextBlock3 = 0;
 
    integer j = 0;
    integer l = (data != []);
    list output = [];
    while (l > 0) {
        
        if (lslAESMode == 1) {
            
            nextBlock0 = llList2Integer(data, 0);
            lslAESStateX0Y0 = ((nextBlock0 >> 24) & 0xFF);
            lslAESStateX0Y1 = ((nextBlock0 >> 16) & 0xFF);
            lslAESStateX0Y2 = ((nextBlock0 >> 8 ) & 0xFF);
            lslAESStateX0Y3 = ((nextBlock0      ) & 0xFF);
            nextBlock1 = llList2Integer(data, 1);
            lslAESStateX1Y0 = ((nextBlock1 >> 24) & 0xFF);
            lslAESStateX1Y1 = ((nextBlock1 >> 16) & 0xFF);
            lslAESStateX1Y2 = ((nextBlock1 >> 8 ) & 0xFF);
            lslAESStateX1Y3 = ((nextBlock1      ) & 0xFF);
            nextBlock2 = llList2Integer(data, 2);
            lslAESStateX2Y0 = ((nextBlock2 >> 24) & 0xFF);
            lslAESStateX2Y1 = ((nextBlock2 >> 16) & 0xFF);
            lslAESStateX2Y2 = ((nextBlock2 >> 8 ) & 0xFF);
            lslAESStateX2Y3 = ((nextBlock2      ) & 0xFF);
            nextBlock3 = llList2Integer(data, 3);
            lslAESStateX3Y0 = ((nextBlock3 >> 24) & 0xFF);
            lslAESStateX3Y1 = ((nextBlock3 >> 16) & 0xFF);
            lslAESStateX3Y2 = ((nextBlock3 >> 8 ) & 0xFF);
            lslAESStateX3Y3 = ((nextBlock3      ) & 0xFF);
        } else if (lslAESMode == LSLAES_MODE_CFB) {
            lslAESStateX0Y0 = ((prevBlock0 >> 24) & 0xFF);
            lslAESStateX0Y1 = ((prevBlock0 >> 16) & 0xFF);
            lslAESStateX0Y2 = ((prevBlock0 >> 8 ) & 0xFF);
            lslAESStateX0Y3 = ((prevBlock0      ) & 0xFF);
 
            lslAESStateX1Y0 = ((prevBlock1 >> 24) & 0xFF);
            lslAESStateX1Y1 = ((prevBlock1 >> 16) & 0xFF);
            lslAESStateX1Y2 = ((prevBlock1 >> 8 ) & 0xFF);
            lslAESStateX1Y3 = ((prevBlock1      ) & 0xFF);
 
            lslAESStateX2Y0 = ((prevBlock2 >> 24) & 0xFF);
            lslAESStateX2Y1 = ((prevBlock2 >> 16) & 0xFF);
            lslAESStateX2Y2 = ((prevBlock2 >> 8 ) & 0xFF);
            lslAESStateX2Y3 = ((prevBlock2      ) & 0xFF);
 
            lslAESStateX3Y0 = ((prevBlock3 >> 24) & 0xFF);
            lslAESStateX3Y1 = ((prevBlock3 >> 16) & 0xFF);
            lslAESStateX3Y2 = ((prevBlock3 >> 8 ) & 0xFF);
            lslAESStateX3Y3 = ((prevBlock3      ) & 0xFF);
        }
 
        if (lslAESMode == LSLAES_MODE_CFB) 
             lslAESPerformCipher(); 
        else {
            
            lslAESAddRoundKey(lslAESRounds);
 
            
            j = lslAESRounds - 1;
            while (j > 0) {
                lslAESInvertShiftRows();
                lslAESInvertSubBytes();
                lslAESAddRoundKey(j--);
                lslAESInvertMixColumns();
            }
 
            
            lslAESInvertShiftRows();
            lslAESInvertSubBytes();
            lslAESAddRoundKey(0);
        }
 
        
        if (lslAESMode == 1) {
             
            output = (output = []) + output + [
                prevBlock0 ^ 
                ((lslAESStateX0Y0 << 24) | (lslAESStateX0Y1 << 16) | 
                    (lslAESStateX0Y2 << 8) | (lslAESStateX0Y3)),
                prevBlock1 ^ 
                ((lslAESStateX1Y0 << 24) | (lslAESStateX1Y1 << 16) | 
                    (lslAESStateX1Y2 << 8) | (lslAESStateX1Y3)),
                prevBlock2 ^ 
                ((lslAESStateX2Y0 << 24) | (lslAESStateX2Y1 << 16) | 
                    (lslAESStateX2Y2 << 8) | (lslAESStateX2Y3)),
                prevBlock3 ^ 
                ((lslAESStateX3Y0 << 24) | (lslAESStateX3Y1 << 16) | 
                    (lslAESStateX3Y2 << 8) | (lslAESStateX3Y3))
            ];
 
            prevBlock0 = nextBlock0;
            prevBlock1 = nextBlock1;
            prevBlock2 = nextBlock2;
            prevBlock3 = nextBlock3;
         } else { 
            
            
            prevBlock0 = llList2Integer(data, 0);
            prevBlock1 = llList2Integer(data, 1);
            prevBlock2 = llList2Integer(data, 2);
            prevBlock3 = llList2Integer(data, 3);
 
            output = (output = []) + output + [
                prevBlock0 ^ 
                ((lslAESStateX0Y0 << 24) | (lslAESStateX0Y1 << 16) | 
                    (lslAESStateX0Y2 << 8) | (lslAESStateX0Y3)),
                prevBlock1 ^ 
                ((lslAESStateX1Y0 << 24) | (lslAESStateX1Y1 << 16) | 
                    (lslAESStateX1Y2 << 8) | (lslAESStateX1Y3)),
                prevBlock2 ^ 
                ((lslAESStateX2Y0 << 24) | (lslAESStateX2Y1 << 16) | 
                    (lslAESStateX2Y2 << 8) | (lslAESStateX2Y3)),
                prevBlock3 ^ 
                ((lslAESStateX3Y0 << 24) | (lslAESStateX3Y1 << 16) | 
                    (lslAESStateX3Y2 << 8) | (lslAESStateX3Y3))
            ];
         }
 
         
        if (l > 4) 
            data = llList2List((data = []) + data, 4, -1);
        else data = [];
        l -= 4;
    }
 
    return (output = []) + output;
}
integer lslAESGetSBoxByte(integer n) {   
    return lslAESAffine(lslAESMultInverse(n));
}
list lslAESCipher(list data) {
    
    lslAESLoadInputVector();
 
    integer l = (data != []);
    integer j = 0;
    list output = [];
 
    while (l > 0) {
        
        if (lslAESMode == 1) {
            
            
            j = llList2Integer(data, 0);
            lslAESStateX0Y0 = lslAESStateX0Y0 ^ ((j >> 24) & 0xFF);
            lslAESStateX0Y1 = lslAESStateX0Y1 ^ ((j >> 16) & 0xFF);
            lslAESStateX0Y2 = lslAESStateX0Y2 ^ ((j >> 8 ) & 0xFF);
            lslAESStateX0Y3 = lslAESStateX0Y3 ^ ((j      ) & 0xFF);
            j = llList2Integer(data, 1);
            lslAESStateX1Y0 = lslAESStateX1Y0 ^ ((j >> 24) & 0xFF);
            lslAESStateX1Y1 = lslAESStateX1Y1 ^ ((j >> 16) & 0xFF);
            lslAESStateX1Y2 = lslAESStateX1Y2 ^ ((j >> 8 ) & 0xFF);
            lslAESStateX1Y3 = lslAESStateX1Y3 ^ ((j      ) & 0xFF);
            j = llList2Integer(data, 2);
            lslAESStateX2Y0 = lslAESStateX2Y0 ^ ((j >> 24) & 0xFF);
            lslAESStateX2Y1 = lslAESStateX2Y1 ^ ((j >> 16) & 0xFF);
            lslAESStateX2Y2 = lslAESStateX2Y2 ^ ((j >> 8 ) & 0xFF);
            lslAESStateX2Y3 = lslAESStateX2Y3 ^ ((j      ) & 0xFF);
            j = llList2Integer(data, 3);
            lslAESStateX3Y0 = lslAESStateX3Y0 ^ ((j >> 24) & 0xFF);
            lslAESStateX3Y1 = lslAESStateX3Y1 ^ ((j >> 16) & 0xFF);
            lslAESStateX3Y2 = lslAESStateX3Y2 ^ ((j >> 8 ) & 0xFF);
            lslAESStateX3Y3 = lslAESStateX3Y3 ^ ((j      ) & 0xFF);
        }
 
        lslAESPerformCipher();
 
        if (lslAESMode == LSLAES_MODE_CFB) {
            
            
            j = llList2Integer(data, 0);
            lslAESStateX0Y0 = lslAESStateX0Y0 ^ ((j >> 24) & 0xFF);
            lslAESStateX0Y1 = lslAESStateX0Y1 ^ ((j >> 16) & 0xFF);
            lslAESStateX0Y2 = lslAESStateX0Y2 ^ ((j >> 8 ) & 0xFF);
            lslAESStateX0Y3 = lslAESStateX0Y3 ^ ((j      ) & 0xFF);
            j = llList2Integer(data, 1);
            lslAESStateX1Y0 = lslAESStateX1Y0 ^ ((j >> 24) & 0xFF);
            lslAESStateX1Y1 = lslAESStateX1Y1 ^ ((j >> 16) & 0xFF);
            lslAESStateX1Y2 = lslAESStateX1Y2 ^ ((j >> 8 ) & 0xFF);
            lslAESStateX1Y3 = lslAESStateX1Y3 ^ ((j      ) & 0xFF);
            j = llList2Integer(data, 2);
            lslAESStateX2Y0 = lslAESStateX2Y0 ^ ((j >> 24) & 0xFF);
            lslAESStateX2Y1 = lslAESStateX2Y1 ^ ((j >> 16) & 0xFF);
            lslAESStateX2Y2 = lslAESStateX2Y2 ^ ((j >> 8 ) & 0xFF);
            lslAESStateX2Y3 = lslAESStateX2Y3 ^ ((j      ) & 0xFF);
            j = llList2Integer(data, 3);
            lslAESStateX3Y0 = lslAESStateX3Y0 ^ ((j >> 24) & 0xFF);
            lslAESStateX3Y1 = lslAESStateX3Y1 ^ ((j >> 16) & 0xFF);
            lslAESStateX3Y2 = lslAESStateX3Y2 ^ ((j >> 8 ) & 0xFF);
            lslAESStateX3Y3 = lslAESStateX3Y3 ^ ((j      ) & 0xFF);
        }
 
        output = (output = []) + output + [
            (lslAESStateX0Y0 << 24) | (lslAESStateX0Y1 << 16) | 
                (lslAESStateX0Y2 << 8) | lslAESStateX0Y3,
            (lslAESStateX1Y0 << 24) | (lslAESStateX1Y1 << 16) | 
                (lslAESStateX1Y2 << 8) | lslAESStateX1Y3,
            (lslAESStateX2Y0 << 24) | (lslAESStateX2Y1 << 16) | 
                (lslAESStateX2Y2 << 8) | lslAESStateX2Y3,
            (lslAESStateX3Y0 << 24) | (lslAESStateX3Y1 << 16) | 
                (lslAESStateX3Y2 << 8) | lslAESStateX3Y3
        ];
 
         
        if (l > 4) 
            data = llList2List((data = []) + data, 4, -1);
        else data = [];
        l -= 4;
    }
 
    return (output = []) + output;
}
list lslAESStringToBytes(string s, integer width, string alphabet) {
    integer l = llStringLength(s);
 
    list n = [l * width]; 
    integer bitbuf = 0;
    integer adjust = 32;
 
    integer i = 0;
    integer val;
    while (i < l) {
        val = llSubStringIndex(alphabet, llGetSubString(s, i, i));
        if (val < 0) {
            s = "";
            return (n = []) + 
                ["Invalid character at index "+(string)i];
        }
 
        if ((adjust -= width) <= 0) {
            bitbuf = bitbuf | (val >> -adjust);
            n = (n = []) + n + [bitbuf];
 
            adjust += 32;
            if (adjust < 32) bitbuf = (val << adjust);
            else bitbuf = 0;
        } else bitbuf = bitbuf | (val << adjust);
 
        ++i;
    }
 
    s = "";
    if (adjust < 32) 
        return (n = []) + n + [bitbuf];
    return (n = []) + n;
}
list lslAESSetInputVector(list data) {
    if ((data != []) < 5) 
        return ["Input vector must be at least 128-bits long"];
 
    
    lslAESInputVector0 = llList2Integer(data, 1);
    lslAESInputVector1 = llList2Integer(data, 2);
    lslAESInputVector2 = llList2Integer(data, 3);
    lslAESInputVector3 = llList2Integer(data, 4);
 
    return [1];
}
list lslAESPadCipher(list data) {
    integer bits = llList2Integer(data, 0);
    data = llDeleteSubList((data = []) + data, 0, 0);
 
    integer padding = lslAESPad;
    if (padding == LSLAES_PAD_NONE) {
        if (lslAESMode == LSLAES_MODE_CFB) 
            return [bits] + lslAESCipher((data = []) + data);
        padding = 1;
    }
 
    integer blockSize = lslAESPadSize;
    if (padding == 1) blockSize = 128;
 
    integer blocks = bits / blockSize;
    integer extra  = bits % blockSize;
 
    if (padding == 1) {
        
        
        
        list final = [];
        if (extra > 0) {
            integer words = extra / 32;
            if ((words * 32) < extra) ++words;
 
            
            list t = llList2List(data, -words, -1);
 
            
            list lb = [];
            if (blocks < 1) {
                
                
                lb = lslAESCipher(
                    lslAESCipher((data = []) + [
                        lslAESInputVector0, lslAESInputVector1, 
                        lslAESInputVector2, lslAESInputVector3
                    ])
                );
            } else {
                
                
                data = lslAESCipher(
                    llDeleteSubList((data = []) + data, -words, -1)
                );
                lb = lslAESCipher(llList2List(data, -4, -1));
            }
 
            
            integer i = 0; integer l = (t != []);
            do 
                final = (final = []) + final + 
                    [llList2Integer(t, i) ^ llList2Integer(lb, i)];
            while ((++i) < l);
 
            return [bits] + (data = final = []) + data + final;
        } 
        return [bits] + lslAESCipher((data = []) + data);
    } else {
        
        
        
        
        
        
        extra = blockSize - extra; 
 
        if (padding == LSLAES_PAD_NULLS_SAFE) {
            ++bits;
            integer words = bits / 32;
            integer bit   = bits % 32;
 
            if (words < (data != [])) {
                integer word = llList2Integer(data, words);
                data = llListReplaceList(
                    (data = []) + data,
                    [word | (1 << (31 - bit))],
                    words,
                    words
                );
            } else data += [0x80000000];
 
            if ((--extra) < 0) extra += blockSize;
            padding = LSLAES_PAD_NULLS;
        }
 
        integer bytes = extra / 8; 
        if (bytes <= 0) {
            if (padding == LSLAES_PAD_NULLS) 
                jump skip; 
 
            bytes = blockSize / 8;
            extra += blockSize;
        }
 
        bits += extra;
 
        integer awords = bytes / 4; 
 
        
        extra = bytes % 4;
        if (extra > 0) {
            integer i = 0; integer v = llList2Integer(data, -1);
            if ((extra == bytes) && (padding != LSLAES_PAD_NULLS)) {
                v = v | bytes;
                i = 1;
            }
 
            integer byte = 0;
            while (i < extra) {
                if (padding == LSLAES_PAD_RANDOM) 
                    byte = (integer)llFrand(256.0) & 0xFF;
 
                v = v | (byte << (i << 3));
                ++i;
            }
 
            data = llListReplaceList((data = []) + data, [v], -1, -1);
        }
 
        
        if (awords > 0) {
            integer final = -1;
            if (padding != LSLAES_PAD_NULLS) 
                final = awords - 1;
 
            integer word = 0; integer byte = 0;
            integer i = 0;
            integer j = 0; list w = [];
            do {
                word = j = 0; 
                do {
                    if ((padding != LSLAES_PAD_NULLS) && 
                        (i == final) && !j) 
                        byte = bytes;
                    else if (padding == LSLAES_PAD_RANDOM) 
                        byte = (integer)llFrand(256.0) & 0xFF;
 
                    word = word | (byte << (j << 3));
                } while ((++j) < 4);
 
                w = (w = []) + w + [word];
            } while ((++i) < awords);
 
            data = (data = w = []) + data + w;
        }
 
        @skip;
        return [bits] + lslAESCipher((data = []) + data);
    }
}
list lslAESKeyExpansion(list keyBytes) {
    
    integer len = (
        (
            lslAESRoundKey = llDeleteSubList( 
                (lslAESRoundKey = keyBytes = []) + keyBytes, 
                0, 
                0
            )
        ) != []); 
 
    
    if ((len < 4) || (len > 8)) {
        lslAESRoundKey = [];
        return ["Invalid key size; must be 128, 192, or 256 bits!"];
    }
 
    
    lslAESRounds = len + 6;
 
    
    integer i = 0;
    integer x = (len * 3) + 28;
 
    integer t = llList2Integer(lslAESRoundKey, -1);
 
    do {
        if (!(i % len)) {
            
            
            t = ((lslAESGetSBoxByte((t >> 16) & 0xFF) ^ 
                     (0x000D8080 >> (7 ^ (i / len)))) << 24) | 
                 (lslAESGetSBoxByte((t >>  8) & 0xFF) << 16) | 
                 (lslAESGetSBoxByte((t      ) & 0xFF) <<  8) |
                  lslAESGetSBoxByte((t >> 24) & 0xFF);
        } else if ((len > 6) && (i % len) == 4) {
            
            t = (lslAESGetSBoxByte((t >> 24) & 0xFF) << 24) | 
                (lslAESGetSBoxByte((t >> 16) & 0xFF) << 16) | 
                (lslAESGetSBoxByte((t >>  8) & 0xFF) <<  8) |
                (lslAESGetSBoxByte((t      ) & 0xFF)      );
        }
 
        
        
        lslAESRoundKey = (lslAESRoundKey = []) + lslAESRoundKey + 
            (t = (t ^ llList2Integer(lslAESRoundKey, i)));
    } while ((i = -~i) < x);
 
    
    return [1];
}
list lslAESInvertPadCipher(list data) {
    integer bits = llList2Integer(data, 0);
    data = llDeleteSubList((data = []) + data, 0, 0);
 
    integer padding = lslAESPad;
    if (padding == LSLAES_PAD_NONE) {
        if (lslAESMode == LSLAES_MODE_CFB) 
            return [bits] + lslAESInvertCipher((data = []) + data);
        padding = 1;
    }
 
    integer blockSize = lslAESPadSize;
    if (padding == 1) blockSize = 128;
 
    integer blocks = bits / blockSize;
    integer extra  = bits % blockSize;
 
    if (padding == 1) {
        
        
        
        list final = [];
        if (extra > 0) {
            integer words = llCeil((float)extra / 32.0);
 
            
            list t = llList2List(data, -words, -1);
 
            
            list lb = [];
            if (blocks < 1) {
                
                
                lb = lslAESCipher(
                    lslAESCipher((data = []) + [
                        lslAESInputVector0, lslAESInputVector1, 
                        lslAESInputVector2, lslAESInputVector3
                    ])
                );
            } else {
                
                
                lb = lslAESCipher(
                    llList2List(data, -(4 + words), -(words + 1))
                );
                data = lslAESInvertCipher(
                    llDeleteSubList((data = []) + data, -words, -1)
                );
            }
 
            
            integer i = 0; integer l = (t != []);
            do 
                final = (final = []) + final + 
                    [llList2Integer(t, i) ^ llList2Integer(lb, i)];
            while ((++i) < l);
 
            return [bits] + (data = final = []) + data + final;
        }
        return [bits] + lslAESInvertCipher((data = []) + data);
    } else {
        
        
        
        
        
        
 
        
        
        
        
        if (extra > 0) {
            bits -= extra;
            extra = llCeil((float)extra / 32.0);
            if (extra <= 0) extra = 1;
 
            if (extra > (data != [])) return [0];
            data = llDeleteSubList((data = []) + data, -extra, -extra);
        }
 
        
        data = lslAESInvertCipher((data = []) + data);
 
        integer bytes = 0; integer words = 0; integer excessBits = 0;
 
        
        if ((padding == LSLAES_PAD_NULLS) || 
            (padding == LSLAES_PAD_NULLS_SAFE)) {
            
            integer l = data != [];
            integer v = 0; integer j = 0;
 
            while (words < l) {
                v = llList2Integer(data, -(words + 1));
 
                if (v == 0) { 
                    ++words;
                    bytes += 4;
                } else {
                    j = 0; integer byte = 0;
                    do {
                        byte = (v >> (j << 3)) & 0xFF;
 
                        if (byte == 0) ++bytes;
                        else jump skip;
                    } while ((++j) < 4);
                }
            }
            @skip;
 
            if (padding == LSLAES_PAD_NULLS_SAFE) {
                integer byte = (v >> (j << 3)) & 0xFF;
                integer i = 1;
                while (i < 0xFF) {
                    ++excessBits;
                    if (byte & i) jump skip2;
                    i = i << 1;
                }
            }
            @skip2;
        } else {
            
            bytes = llList2Integer(data, -1) & 0xFF;
            if ((bytes << 3) >= bits) return [0];
            words = bytes / 4;
        }
 
        
        if (words > 0) 
            data = llDeleteSubList((data = []) + data, -words, -1);
 
        
        bits -= (bytes << 3) + excessBits;
 
        return [bits] + (data = []) + data;
    }
}
list lslAESHexToBytes(string hexData) {
    if (llGetSubString(hexData, 0, 1) == "0x") 
        hexData = llDeleteSubString((hexData = "") + hexData, 0, 1);
    return lslAESStringToBytes(
        llToLower((hexData = "") + hexData), 
        4, 
        LSLAES_HEX_CHARS
    );
}
string lslAESBytesToString(list b, integer width, string alphabet) {
    integer bits = llList2Integer(b, 0);
 
    integer i = 0;
    integer mask = ~(-1 << width);
    integer shift = 32 - width;
 
    integer available = 0;
    integer prev = 0;
    integer buf;
    integer extra;
    integer value;
 
    string s = "";
 
    @lslAESBytesToStringLoop;
    if((bits -= 32) > -32) {
        available += 32 + (bits * (0 > bits));
        buf = llList2Integer(b, ++i);
        if (available >= width) {
            if (prev) {
                s = (s = "") + s + 
                    llGetSubString(
                        alphabet, 
                        value = (
                            extra | 
                            (
                                (buf >> (shift + prev)) & 
                                ~(-1 << (width - prev))
                            )
                        ), 
                        value
                    );
                buf = buf << (width - prev);
                available -= width;
            }
            while(available >= width) {
                s = (s = "") + s + 
                    llGetSubString(
                        alphabet, 
                        value = ((buf >> shift) & mask),
                        value
                    );
                buf = buf << width;
                available -= width;
            }
            if (prev = available) 
                extra = (buf >> shift) & mask;
            jump lslAESBytesToStringLoop;
        }
    }
    if(available) {
        mask = -1 << (width - prev);
        return (s = "") + s + 
            llGetSubString(
                alphabet, 
                value = ((extra & mask) | 
                        (
                            (buf >> (shift + prev)) & 
                            ((-1 << (width - available)) ^ mask))
                        ), 
                value
            );
    }
    return (s = "") + s;
}
string lslAESBytesToHex(list b) {
    return "0x" + lslAESBytesToString((b = []) + b, 4, LSLAES_HEX_CHARS);
}
string lslAESBytesToBase64(list b) {
    string s = lslAESBytesToString((b = []) + b, 6, LSLAES_BASE64_CHARS);
    integer l = llStringLength(s) % 4;
    if (l) {
        if (l == 2) return (s = "") + s + "==";
        return (s = "") + s + "=";
    }
    return (s = "") + s;
}
list lslAESBase64ToBytes(string base64Data) {
    integer x = llSubStringIndex(base64Data, "=");
    if (x > 0) 
        base64Data = llDeleteSubString(
            (base64Data = "") + base64Data, 
            x,
            -1
        );
    return lslAESStringToBytes(
        (base64Data = "") + base64Data, 
        6, 
        LSLAES_BASE64_CHARS
    );
}

 










 




 








 


 









 



 



 








 
error(integer link, string str, key id) {
    llMessageLinked(
        link,
        LSLAES_FILTER_REPLY | LSLAES_COMMAND_ERROR,
        str,
        id
    );
}

 
default {    
    link_message(integer x, integer y, string msg, key id) {        
        
        if ((y & LSLAES_FILTER_MASK) == LSLAES_FILTER_REQUEST) {
            
            if (llStringLength(msg) > LSLAES_MAX_SIZE) {
                error(
                    x, 
                    "Maxmimum message length is " + 
                    (string)LSLAES_MAX_SIZE + 
                    " characters", 
                    id
                );
                return;
            }
 
            
            if ((y & LSLAES_COMMAND_MASK) == LSLAES_COMMAND_SETUP) {
                
                if (msg != "") {
                    list flags = llCSV2List((msg = "") + msg);
                    integer i = 0; integer l = (flags != []);
                       integer j = 0; list flag = [];
                       do {
                           flag = [llToUpper(llList2String(flags, i))];
 
                           if ((j = llListFindList(LSLAES_MODES, flag)) >= 0) 
                               lslAESMode = llList2Integer(LSLAES_MODES, ++j);
                           else if ((j = llListFindList(LSLAES_PADS, flag)) >= 0) 
                               lslAESPad  = llList2Integer(LSLAES_PADS, ++j);
                           else if ((string)flag == "PAD_SIZE") {
                               j = llList2Integer(flags, ++i); 
                               if (j <= 0) j = 512;
                               else if (j > 512) {
                                   error(x, "Maximum pad-size is "+(string)512+" bits", id);
                                   return;
                               } else if (j % 128) {
                                   error(x, "Pad-size must be a multiple of 128-bits", id);
                                   return;
                               }
 
                               lslAESPadSize = j;
                           } else {
                               error(x, "Unsupported flag '"+(string)flag+"'", id);
                               return;
                           }
                       } while ((++i) < l);
                }
 
                   
                llMessageLinked(
                    x,
                    LSLAES_FILTER_REPLY | LSLAES_COMMAND_SETUP,
                    "",
                    id
                );
                return;
            }
 
            
            integer type = y & LSLAES_INPUT_TYPE_MASK;
            list data = [];
            if (type == LSLAES_INPUT_HEX) 
                data = lslAESHexToBytes((msg = "") + msg);
            else if (type == LSLAES_INPUT_BASE64) 
                data = lslAESBase64ToBytes((msg = "") + msg);
            else data = [(msg = "") + "Unsupported input-type"];
 
            
            if (llGetListEntryType(data, 0) != TYPE_INTEGER) {
                error(x, llList2String((data = []) + data, 0), id);
                return;
            }
 
            
            type = y & LSLAES_COMMAND_MASK;
            if (type == LSLAES_COMMAND_PRIME) 
                data = lslAESKeyExpansion((data = []) + data);
            else if (type == LSLAES_COMMAND_ENCRYPT) 
                data = lslAESPadCipher((data = []) + data);
            else if (type == LSLAES_COMMAND_DECRYPT) 
                data = lslAESInvertPadCipher((data = []) + data);
            else if (type == LSLAES_COMMAND_INIT) 
                data = lslAESSetInputVector((data = []) + data);
            else data = ["Unsupported mode"];
 
            
            if (llGetListEntryType(data, 0) != TYPE_INTEGER) {
                error(x, llList2String((data = []) + data, 0), id);
                return;
            }
 
            
            integer output = 0;
 
            if ((type != LSLAES_COMMAND_PRIME) && (type != LSLAES_COMMAND_INIT)) {
                output = y & LSLAES_OUTPUT_TYPE_MASK;
                if (output == LSLAES_OUTPUT_HEX) {
                    msg = lslAESBytesToHex((data = []) + data);
                    output = LSLAES_INPUT_HEX;
                } else if (output == LSLAES_OUTPUT_BASE64) {
                    msg = lslAESBytesToBase64((data = []) + data);
                    output = LSLAES_INPUT_BASE64;
                } else {
                    error(x, "Invalid output type", id);
                    return;
                }
            }
 
            
            llMessageLinked(
                x,
                LSLAES_FILTER_REPLY | type | output,
                (msg = "") + msg,
                id
            );
        }
    }
}
