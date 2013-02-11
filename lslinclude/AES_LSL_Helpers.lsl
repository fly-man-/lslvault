// Add necessary functions from https://wiki.secondlife.com/wiki/AES_LSL_Helpers here
// These variables are used to build communications. Commands are sent as 
// combined bits in the integer argument of a link-message, and are 
// recovered using masks, you may wish to read about bit-masks before 
// editing these values. These are used so the string argument is 
// kept free for data only.
//
// Commands take the following form (in hex):
//      0xFFMMIOvv
// Where the letters are:
//      F   Filter, used to quickly determine if a message is for us.
//      C   Command; encrypt/decrypt etc.
//      I   Type of data provided (hex, base64, etc.).
//      O   Desired type of data to be returned (hex, base64, etc.), 
//          this is unused in replies as the reply's value for I will 
//          be the request's value for O.
//      v   Variable, depends on mode.
 
// This mask allows the filter byte to be retrieved quickly
integer LSLAES_FILTER_MASK      = 0xFF000000;
// This mask allows the mask byte to be retrieved quickly
integer LSLAES_COMMAND_MASK     = 0x00FF0000;
// This mask allows the input type to be retrieved quickly
integer LSLAES_INPUT_TYPE_MASK  = 0x0000F000;
// This mask allows the output type to be retireved quickly
integer LSLAES_OUTPUT_TYPE_MASK = 0x00000F00;
// This mask allows the variable to retrieved quickly
integer LSLAES_VARIABLE_MASK    = 0x000000FF;
// How many bits right variable must be shifted
integer LSLAES_VARIABLE_SHIFT   = 0;
 
// A request
integer LSLAES_FILTER_REQUEST   = 0x81000000;
// A reply
integer LSLAES_FILTER_REPLY     = 0x82000000;
 
// An error occurred
integer LSLAES_COMMAND_ERROR    = 0x00000000;
// Prime engine with key
integer LSLAES_COMMAND_PRIME    = 0x00010000;
// Encrypt message using expanded key
integer LSLAES_COMMAND_ENCRYPT  = 0x00020000;
// Decrypt message using expanded key
integer LSLAES_COMMAND_DECRYPT  = 0x00030000;
// Sets-up the engine by specifying comma-separated flags
integer LSLAES_COMMAND_SETUP    = 0x00050000;
// Initialise the engine with an input-vector
integer LSLAES_COMMAND_INIT     = 0x00060000;
 
// Input type is hex
integer LSLAES_INPUT_HEX        = 0x00000000;
// Input type is base64
integer LSLAES_INPUT_BASE64     = 0x00001000;
 
// Output type is hex
integer LSLAES_OUTPUT_HEX       = 0x00000000;
// Output type is base64
integer LSLAES_OUTPUT_BASE64    = 0x00000100;
 
// The following extra variables are used to track our messages
key     requestID               = NULL_KEY;
 
// Sets-up the AES engine. Flags is a comma-separated list with the 
// following possible entries:
//  MODE_ECB    - Sets Electronic Code-Book mode, a little faster but 
//                not especially secure
//  MODE_CBC    - Cipher-Block-Chaining mode, most commonly used, good 
//                security.
//  MODE_CFB    - Ciphertext Feed-Back mode. Similar to CBC, but does 
//                not require an inverse-cipher to decrypt.
//  MODE_NOFB   - Output Feed-Back mode. Similar to CFB.
//
//  PAD_RBT     - Residual Block Termination padding is a method of 
//                encrypting data that does not fit correctly within 
//                into blocks.
//  PAD_NULLS   - Mainly added to provide support for PHP's mcrypt 
//                library. Null-characters (zero-bytes) are added to 
//                pad the length. ALL nulls are removed from the end 
//                after decryption, so be careful if null-characters 
//                occur within the text naturally.
//  PAD_ZEROES  - Adds zero-bytes, with the final byte describing the 
//                number of bytes added. If data fits within padSize 
//                then an extra padSize bits is added.
//  PAD_RANDOM  - Identical to PAD_ZEROES except that random bytes are 
//                generated for padding.
//
//  PAD_SIZE    - Defines the length of padding for NULLS, ZEROES, and 
//                random to align on. After this should be an integer 
//                value defining the size. Must be a multiple of 128.
lslAESSetup(integer targetLink, string flags, key id) {
    llMessageLinked(
        targetLink,
        LSLAES_FILTER_REQUEST | LSLAES_COMMAND_SETUP,
        (flags = "") + flags,
        requestID = id
    );
}
 
// Sends a link message to targetLink, requesting that aesKey be used to 
// prime the AES engine. aesKey should be a hexadecimal string representing 
// a value that is 128, 192, or 256-bits in length.
lslAESPrimeHexKey(integer targetLink, string aesKey, key id) {
    llMessageLinked(
        targetLink,
        LSLAES_FILTER_REQUEST | LSLAES_COMMAND_PRIME | LSLAES_INPUT_HEX,
        (aesKey = "") + aesKey,
        requestID = id
    );
}
 
// Initialises a 128-bit input-vector to be used by the AES engine
lslAESInitHexIV(integer targetLink, string iv, key id) {
    llMessageLinked(
        targetLink,
        LSLAES_FILTER_REQUEST | LSLAES_COMMAND_INIT | LSLAES_INPUT_HEX,
        (iv = "") + iv,
        requestID = id
    );
}
 
// Sends hexadecimal data and gets encrypted hexadecimal data back
lslAESEncryptHexToHex(integer targetLink, string hexData, key id) {
    llMessageLinked(
        targetLink,
        LSLAES_FILTER_REQUEST | LSLAES_COMMAND_ENCRYPT | 
            LSLAES_INPUT_HEX | LSLAES_OUTPUT_HEX,
        (hexData = "") + hexData,
        requestID = id
    );
}
 
// Sends hexadecimal data and gets encrypted base64 data back
lslAESEncryptHexToBase64(integer targetLink, string hexData, key id) {
    llMessageLinked(
        targetLink,
        LSLAES_FILTER_REQUEST | LSLAES_COMMAND_ENCRYPT | 
            LSLAES_INPUT_HEX | LSLAES_OUTPUT_BASE64,
        (hexData = "") + hexData,
        requestID = id
    );
}
 
// Send base64 data and gets encrypted hexadecimal data back
lslAESEncryptBase64ToHex(integer targetLink, string b64Data, key id) {
    llMessageLinked(
        targetLink,
        LSLAES_FILTER_REQUEST | LSLAES_COMMAND_ENCRYPT | 
            LSLAES_INPUT_BASE64 | LSLAES_OUTPUT_HEX,
        (b64Data = "") + b64Data,
        requestID = id
    );    
}
 
// Send base64 data and gets encrypted hexadecimal data back
lslAESEncryptBase64ToBase64(integer targetLink, string b64Data, key id) {
    llMessageLinked(
        targetLink,
        LSLAES_FILTER_REQUEST | LSLAES_COMMAND_ENCRYPT | 
            LSLAES_INPUT_BASE64 | LSLAES_OUTPUT_BASE64,
        (b64Data = "") + b64Data,
        requestID = id
    );    
}
 
// Sends hexadecimal data and gets decrypted hexadecimal data back
lslAESDecryptHexToHex(integer targetLink, string hexData, key id) {
    llMessageLinked(
        targetLink,
        LSLAES_FILTER_REQUEST | LSLAES_COMMAND_DECRYPT | 
            LSLAES_INPUT_HEX | LSLAES_OUTPUT_HEX,
        (hexData = "") + hexData,
        requestID = id
    );
}
 
// Sends hexadecimal data and gets decrypted base64 data back
lslAESDecryptHexToBase64(integer targetLink, string hexData, key id) {
    llMessageLinked(
        targetLink,
        LSLAES_FILTER_REQUEST | LSLAES_COMMAND_DECRYPT | 
            LSLAES_INPUT_HEX | LSLAES_OUTPUT_BASE64,
        (hexData = "") + hexData,
        requestID = id
    );
}
 
// Send base64 data and gets decrypted hexadecimal data back
lslAESDecryptBase64ToHex(integer targetLink, string b64Data, key id) {
    llMessageLinked(
        targetLink,
        LSLAES_FILTER_REQUEST | LSLAES_COMMAND_DECRYPT | 
            LSLAES_INPUT_BASE64 | LSLAES_OUTPUT_HEX,
        (b64Data = "") + b64Data,
        requestID = id
    );    
}
 
// Send base64 data and gets decrypted hexadecimal data back
lslAESDecryptBase64ToBase64(integer targetLink, string b64Data, key id) {
    llMessageLinked(
        targetLink,
        LSLAES_FILTER_REQUEST | LSLAES_COMMAND_DECRYPT | 
            LSLAES_INPUT_BASE64 | LSLAES_OUTPUT_BASE64,
        (b64Data = "") + b64Data,
        requestID = id
    );    
}
 
// Tests to see if a message is a reply or not (TRUE/FALSE)
integer lslAESIsReply(integer int, key id) {
    return (
        ((int & LSLAES_FILTER_MASK) == LSLAES_FILTER_REPLY) && 
        (id == requestID)
    );
}
 
// Grabs the mode of this reply. Should be one of the LSLAES_COMMAND_* constants
integer lslAESGetReplyMode(integer int) {
    return (int & LSLAES_COMMAND_MASK);
}
 
// Grabs the data type of this reply. Should be one of the LSLAES_INPUT_* 
// constants.
integer lslAESGetReplyDataType(integer int) {
    return (int & LSLAES_INPUT_TYPE_MASK);
}

   
default {
	state_entry() { // Setup the engine for use
		debug("default state");
        lslAESSetup(
            LINK_THIS,
            "MODE_CBC,"+     // CBC mode is a good, strong mode
            "PAD_NULLS,"+    // Pad with null-chars (zero-bytes)
            "PAD_SIZE,512",  // Pad into blocks of 512-bits
            llGetKey()
        );
    }
 
link_message(integer x, integer y, string msg, key id) {
		if (!lslAESIsReply(y, id)) return;
 		debug("replied from setup");

        y = lslAESGetReplyMode(y);
        if (y == LSLAES_COMMAND_ERROR) 
            llOwnerSay("ERROR: "+msg);
        else if (y == LSLAES_COMMAND_SETUP) 
            state prime;
    }
}
 
state prime {
	state_entry() { // First prime the engine with a key
		debug("state prime");
        lslAESPrimeHexKey(
            LINK_THIS,
            myKey,
            llGetKey()
        );
    }
 
    link_message(integer x, integer y, string msg, key id) {
	if (!lslAESIsReply(y, id)) return;
	debug("replied in prime");
 
        y = lslAESGetReplyMode(y);
        if (y == LSLAES_COMMAND_ERROR) 
            llOwnerSay("ERROR: "+msg);
        else if (y == LSLAES_COMMAND_PRIME) 
            state init;
    }
}
 
state init {
	state_entry() { // Now init the engine with an input vector
		debug("state init");
        lslAESInitHexIV(
            LINK_THIS,
            myIV,
            llGetKey()
        );
    }
 
    link_message(integer x, integer y, string msg, key id) {
        if (!lslAESIsReply(y, id)) return;
 		debug("replied in init");
        y = lslAESGetReplyMode(y);
        if (y == LSLAES_COMMAND_ERROR) 
            llOwnerSay("ERROR: "+msg);
        else if (y == LSLAES_COMMAND_INIT) 
            state start;
    }
}
