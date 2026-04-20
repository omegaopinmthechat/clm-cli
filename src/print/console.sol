// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

library console {

    // Events
    event LogString(string);
    event LogUint(uint);
    event LogInt(int);
    event LogAddress(address);
    event LogBool(bool);
    event LogBytes32(bytes32);
    event LogBytes(bytes);
    event LogStringString(string, string);
    event LogStringUint(string, uint);
    event LogStringInt(string, int);
    event LogStringAddress(string, address);
    event LogStringBool(string, bool);
    event LogStringBytes32(string, bytes32);
    event LogStringBytes(string, bytes);
    event LogUintString(uint, string);
    event LogUintUint(uint, uint);
    event LogUintInt(uint, int);
    event LogUintAddress(uint, address);
    event LogUintBool(uint, bool);
    event LogUintBytes32(uint, bytes32);
    event LogUintBytes(uint, bytes);
    event LogIntString(int, string);
    event LogIntUint(int, uint);
    event LogIntInt(int, int);
    event LogIntAddress(int, address);
    event LogIntBool(int, bool);
    event LogIntBytes32(int, bytes32);
    event LogIntBytes(int, bytes);
    event LogAddressString(address, string);
    event LogAddressUint(address, uint);
    event LogAddressInt(address, int);
    event LogAddressAddress(address, address);
    event LogAddressBool(address, bool);
    event LogAddressBytes32(address, bytes32);
    event LogAddressBytes(address, bytes);
    event LogBoolString(bool, string);
    event LogBoolUint(bool, uint);
    event LogBoolInt(bool, int);
    event LogBoolAddress(bool, address);
    event LogBoolBool(bool, bool);
    event LogBoolBytes32(bool, bytes32);
    event LogBoolBytes(bool, bytes);
    event LogBytes32String(bytes32, string);
    event LogBytes32Uint(bytes32, uint);
    event LogBytes32Int(bytes32, int);
    event LogBytes32Address(bytes32, address);
    event LogBytes32Bool(bytes32, bool);
    event LogBytes32Bytes32(bytes32, bytes32);
    event LogBytes32Bytes(bytes32, bytes);
    event LogBytesString(bytes, string);
    event LogBytesUint(bytes, uint);
    event LogBytesInt(bytes, int);
    event LogBytesAddress(bytes, address);
    event LogBytesBool(bytes, bool);
    event LogBytesBytes32(bytes, bytes32);
    event LogBytesBytes(bytes, bytes);
    event LogStringStringString(string, string, string);
    event LogStringStringUint(string, string, uint);
    event LogStringStringInt(string, string, int);
    event LogStringStringAddress(string, string, address);
    event LogStringStringBool(string, string, bool);
    event LogStringStringBytes32(string, string, bytes32);
    event LogStringStringBytes(string, string, bytes);
    event LogStringUintString(string, uint, string);
    event LogStringUintUint(string, uint, uint);
    event LogStringUintInt(string, uint, int);
    event LogStringUintAddress(string, uint, address);
    event LogStringUintBool(string, uint, bool);
    event LogStringUintBytes32(string, uint, bytes32);
    event LogStringUintBytes(string, uint, bytes);
    event LogStringIntString(string, int, string);
    event LogStringIntUint(string, int, uint);
    event LogStringIntInt(string, int, int);
    event LogStringIntAddress(string, int, address);
    event LogStringIntBool(string, int, bool);
    event LogStringIntBytes32(string, int, bytes32);
    event LogStringIntBytes(string, int, bytes);
    event LogStringAddressString(string, address, string);
    event LogStringAddressUint(string, address, uint);
    event LogStringAddressInt(string, address, int);
    event LogStringAddressAddress(string, address, address);
    event LogStringAddressBool(string, address, bool);
    event LogStringAddressBytes32(string, address, bytes32);
    event LogStringAddressBytes(string, address, bytes);
    event LogStringBoolString(string, bool, string);
    event LogStringBoolUint(string, bool, uint);
    event LogStringBoolInt(string, bool, int);
    event LogStringBoolAddress(string, bool, address);
    event LogStringBoolBool(string, bool, bool);
    event LogStringBoolBytes32(string, bool, bytes32);
    event LogStringBoolBytes(string, bool, bytes);
    event LogStringBytes32String(string, bytes32, string);
    event LogStringBytes32Uint(string, bytes32, uint);
    event LogStringBytes32Int(string, bytes32, int);
    event LogStringBytes32Address(string, bytes32, address);
    event LogStringBytes32Bool(string, bytes32, bool);
    event LogStringBytes32Bytes32(string, bytes32, bytes32);
    event LogStringBytes32Bytes(string, bytes32, bytes);
    event LogStringBytesString(string, bytes, string);
    event LogStringBytesUint(string, bytes, uint);
    event LogStringBytesInt(string, bytes, int);
    event LogStringBytesAddress(string, bytes, address);
    event LogStringBytesBool(string, bytes, bool);
    event LogStringBytesBytes32(string, bytes, bytes32);
    event LogStringBytesBytes(string, bytes, bytes);
    event LogUintStringString(uint, string, string);
    event LogUintStringUint(uint, string, uint);
    event LogUintStringInt(uint, string, int);
    event LogUintStringAddress(uint, string, address);
    event LogUintStringBool(uint, string, bool);
    event LogUintStringBytes32(uint, string, bytes32);
    event LogUintStringBytes(uint, string, bytes);
    event LogUintUintString(uint, uint, string);
    event LogUintUintUint(uint, uint, uint);
    event LogUintUintInt(uint, uint, int);
    event LogUintUintAddress(uint, uint, address);
    event LogUintUintBool(uint, uint, bool);
    event LogUintUintBytes32(uint, uint, bytes32);
    event LogUintUintBytes(uint, uint, bytes);
    event LogUintIntString(uint, int, string);
    event LogUintIntUint(uint, int, uint);
    event LogUintIntInt(uint, int, int);
    event LogUintIntAddress(uint, int, address);
    event LogUintIntBool(uint, int, bool);
    event LogUintIntBytes32(uint, int, bytes32);
    event LogUintIntBytes(uint, int, bytes);
    event LogUintAddressString(uint, address, string);
    event LogUintAddressUint(uint, address, uint);
    event LogUintAddressInt(uint, address, int);
    event LogUintAddressAddress(uint, address, address);
    event LogUintAddressBool(uint, address, bool);
    event LogUintAddressBytes32(uint, address, bytes32);
    event LogUintAddressBytes(uint, address, bytes);
    event LogUintBoolString(uint, bool, string);
    event LogUintBoolUint(uint, bool, uint);
    event LogUintBoolInt(uint, bool, int);
    event LogUintBoolAddress(uint, bool, address);
    event LogUintBoolBool(uint, bool, bool);
    event LogUintBoolBytes32(uint, bool, bytes32);
    event LogUintBoolBytes(uint, bool, bytes);
    event LogUintBytes32String(uint, bytes32, string);
    event LogUintBytes32Uint(uint, bytes32, uint);
    event LogUintBytes32Int(uint, bytes32, int);
    event LogUintBytes32Address(uint, bytes32, address);
    event LogUintBytes32Bool(uint, bytes32, bool);
    event LogUintBytes32Bytes32(uint, bytes32, bytes32);
    event LogUintBytes32Bytes(uint, bytes32, bytes);
    event LogUintBytesString(uint, bytes, string);
    event LogUintBytesUint(uint, bytes, uint);
    event LogUintBytesInt(uint, bytes, int);
    event LogUintBytesAddress(uint, bytes, address);
    event LogUintBytesBool(uint, bytes, bool);
    event LogUintBytesBytes32(uint, bytes, bytes32);
    event LogUintBytesBytes(uint, bytes, bytes);
    event LogIntStringString(int, string, string);
    event LogIntStringUint(int, string, uint);
    event LogIntStringInt(int, string, int);
    event LogIntStringAddress(int, string, address);
    event LogIntStringBool(int, string, bool);
    event LogIntStringBytes32(int, string, bytes32);
    event LogIntStringBytes(int, string, bytes);
    event LogIntUintString(int, uint, string);
    event LogIntUintUint(int, uint, uint);
    event LogIntUintInt(int, uint, int);
    event LogIntUintAddress(int, uint, address);
    event LogIntUintBool(int, uint, bool);
    event LogIntUintBytes32(int, uint, bytes32);
    event LogIntUintBytes(int, uint, bytes);
    event LogIntIntString(int, int, string);
    event LogIntIntUint(int, int, uint);
    event LogIntIntInt(int, int, int);
    event LogIntIntAddress(int, int, address);
    event LogIntIntBool(int, int, bool);
    event LogIntIntBytes32(int, int, bytes32);
    event LogIntIntBytes(int, int, bytes);
    event LogIntAddressString(int, address, string);
    event LogIntAddressUint(int, address, uint);
    event LogIntAddressInt(int, address, int);
    event LogIntAddressAddress(int, address, address);
    event LogIntAddressBool(int, address, bool);
    event LogIntAddressBytes32(int, address, bytes32);
    event LogIntAddressBytes(int, address, bytes);
    event LogIntBoolString(int, bool, string);
    event LogIntBoolUint(int, bool, uint);
    event LogIntBoolInt(int, bool, int);
    event LogIntBoolAddress(int, bool, address);
    event LogIntBoolBool(int, bool, bool);
    event LogIntBoolBytes32(int, bool, bytes32);
    event LogIntBoolBytes(int, bool, bytes);
    event LogIntBytes32String(int, bytes32, string);
    event LogIntBytes32Uint(int, bytes32, uint);
    event LogIntBytes32Int(int, bytes32, int);
    event LogIntBytes32Address(int, bytes32, address);
    event LogIntBytes32Bool(int, bytes32, bool);
    event LogIntBytes32Bytes32(int, bytes32, bytes32);
    event LogIntBytes32Bytes(int, bytes32, bytes);
    event LogIntBytesString(int, bytes, string);
    event LogIntBytesUint(int, bytes, uint);
    event LogIntBytesInt(int, bytes, int);
    event LogIntBytesAddress(int, bytes, address);
    event LogIntBytesBool(int, bytes, bool);
    event LogIntBytesBytes32(int, bytes, bytes32);
    event LogIntBytesBytes(int, bytes, bytes);
    event LogAddressStringString(address, string, string);
    event LogAddressStringUint(address, string, uint);
    event LogAddressStringInt(address, string, int);
    event LogAddressStringAddress(address, string, address);
    event LogAddressStringBool(address, string, bool);
    event LogAddressStringBytes32(address, string, bytes32);
    event LogAddressStringBytes(address, string, bytes);
    event LogAddressUintString(address, uint, string);
    event LogAddressUintUint(address, uint, uint);
    event LogAddressUintInt(address, uint, int);
    event LogAddressUintAddress(address, uint, address);
    event LogAddressUintBool(address, uint, bool);
    event LogAddressUintBytes32(address, uint, bytes32);
    event LogAddressUintBytes(address, uint, bytes);
    event LogAddressIntString(address, int, string);
    event LogAddressIntUint(address, int, uint);
    event LogAddressIntInt(address, int, int);
    event LogAddressIntAddress(address, int, address);
    event LogAddressIntBool(address, int, bool);
    event LogAddressIntBytes32(address, int, bytes32);
    event LogAddressIntBytes(address, int, bytes);
    event LogAddressAddressString(address, address, string);
    event LogAddressAddressUint(address, address, uint);
    event LogAddressAddressInt(address, address, int);
    event LogAddressAddressAddress(address, address, address);
    event LogAddressAddressBool(address, address, bool);
    event LogAddressAddressBytes32(address, address, bytes32);
    event LogAddressAddressBytes(address, address, bytes);
    event LogAddressBoolString(address, bool, string);
    event LogAddressBoolUint(address, bool, uint);
    event LogAddressBoolInt(address, bool, int);
    event LogAddressBoolAddress(address, bool, address);
    event LogAddressBoolBool(address, bool, bool);
    event LogAddressBoolBytes32(address, bool, bytes32);
    event LogAddressBoolBytes(address, bool, bytes);
    event LogAddressBytes32String(address, bytes32, string);
    event LogAddressBytes32Uint(address, bytes32, uint);
    event LogAddressBytes32Int(address, bytes32, int);
    event LogAddressBytes32Address(address, bytes32, address);
    event LogAddressBytes32Bool(address, bytes32, bool);
    event LogAddressBytes32Bytes32(address, bytes32, bytes32);
    event LogAddressBytes32Bytes(address, bytes32, bytes);
    event LogAddressBytesString(address, bytes, string);
    event LogAddressBytesUint(address, bytes, uint);
    event LogAddressBytesInt(address, bytes, int);
    event LogAddressBytesAddress(address, bytes, address);
    event LogAddressBytesBool(address, bytes, bool);
    event LogAddressBytesBytes32(address, bytes, bytes32);
    event LogAddressBytesBytes(address, bytes, bytes);
    event LogBoolStringString(bool, string, string);
    event LogBoolStringUint(bool, string, uint);
    event LogBoolStringInt(bool, string, int);
    event LogBoolStringAddress(bool, string, address);
    event LogBoolStringBool(bool, string, bool);
    event LogBoolStringBytes32(bool, string, bytes32);
    event LogBoolStringBytes(bool, string, bytes);
    event LogBoolUintString(bool, uint, string);
    event LogBoolUintUint(bool, uint, uint);
    event LogBoolUintInt(bool, uint, int);
    event LogBoolUintAddress(bool, uint, address);
    event LogBoolUintBool(bool, uint, bool);
    event LogBoolUintBytes32(bool, uint, bytes32);
    event LogBoolUintBytes(bool, uint, bytes);
    event LogBoolIntString(bool, int, string);
    event LogBoolIntUint(bool, int, uint);
    event LogBoolIntInt(bool, int, int);
    event LogBoolIntAddress(bool, int, address);
    event LogBoolIntBool(bool, int, bool);
    event LogBoolIntBytes32(bool, int, bytes32);
    event LogBoolIntBytes(bool, int, bytes);
    event LogBoolAddressString(bool, address, string);
    event LogBoolAddressUint(bool, address, uint);
    event LogBoolAddressInt(bool, address, int);
    event LogBoolAddressAddress(bool, address, address);
    event LogBoolAddressBool(bool, address, bool);
    event LogBoolAddressBytes32(bool, address, bytes32);
    event LogBoolAddressBytes(bool, address, bytes);
    event LogBoolBoolString(bool, bool, string);
    event LogBoolBoolUint(bool, bool, uint);
    event LogBoolBoolInt(bool, bool, int);
    event LogBoolBoolAddress(bool, bool, address);
    event LogBoolBoolBool(bool, bool, bool);
    event LogBoolBoolBytes32(bool, bool, bytes32);
    event LogBoolBoolBytes(bool, bool, bytes);
    event LogBoolBytes32String(bool, bytes32, string);
    event LogBoolBytes32Uint(bool, bytes32, uint);
    event LogBoolBytes32Int(bool, bytes32, int);
    event LogBoolBytes32Address(bool, bytes32, address);
    event LogBoolBytes32Bool(bool, bytes32, bool);
    event LogBoolBytes32Bytes32(bool, bytes32, bytes32);
    event LogBoolBytes32Bytes(bool, bytes32, bytes);
    event LogBoolBytesString(bool, bytes, string);
    event LogBoolBytesUint(bool, bytes, uint);
    event LogBoolBytesInt(bool, bytes, int);
    event LogBoolBytesAddress(bool, bytes, address);
    event LogBoolBytesBool(bool, bytes, bool);
    event LogBoolBytesBytes32(bool, bytes, bytes32);
    event LogBoolBytesBytes(bool, bytes, bytes);
    event LogBytes32StringString(bytes32, string, string);
    event LogBytes32StringUint(bytes32, string, uint);
    event LogBytes32StringInt(bytes32, string, int);
    event LogBytes32StringAddress(bytes32, string, address);
    event LogBytes32StringBool(bytes32, string, bool);
    event LogBytes32StringBytes32(bytes32, string, bytes32);
    event LogBytes32StringBytes(bytes32, string, bytes);
    event LogBytes32UintString(bytes32, uint, string);
    event LogBytes32UintUint(bytes32, uint, uint);
    event LogBytes32UintInt(bytes32, uint, int);
    event LogBytes32UintAddress(bytes32, uint, address);
    event LogBytes32UintBool(bytes32, uint, bool);
    event LogBytes32UintBytes32(bytes32, uint, bytes32);
    event LogBytes32UintBytes(bytes32, uint, bytes);
    event LogBytes32IntString(bytes32, int, string);
    event LogBytes32IntUint(bytes32, int, uint);
    event LogBytes32IntInt(bytes32, int, int);
    event LogBytes32IntAddress(bytes32, int, address);
    event LogBytes32IntBool(bytes32, int, bool);
    event LogBytes32IntBytes32(bytes32, int, bytes32);
    event LogBytes32IntBytes(bytes32, int, bytes);
    event LogBytes32AddressString(bytes32, address, string);
    event LogBytes32AddressUint(bytes32, address, uint);
    event LogBytes32AddressInt(bytes32, address, int);
    event LogBytes32AddressAddress(bytes32, address, address);
    event LogBytes32AddressBool(bytes32, address, bool);
    event LogBytes32AddressBytes32(bytes32, address, bytes32);
    event LogBytes32AddressBytes(bytes32, address, bytes);
    event LogBytes32BoolString(bytes32, bool, string);
    event LogBytes32BoolUint(bytes32, bool, uint);
    event LogBytes32BoolInt(bytes32, bool, int);
    event LogBytes32BoolAddress(bytes32, bool, address);
    event LogBytes32BoolBool(bytes32, bool, bool);
    event LogBytes32BoolBytes32(bytes32, bool, bytes32);
    event LogBytes32BoolBytes(bytes32, bool, bytes);
    event LogBytes32Bytes32String(bytes32, bytes32, string);
    event LogBytes32Bytes32Uint(bytes32, bytes32, uint);
    event LogBytes32Bytes32Int(bytes32, bytes32, int);
    event LogBytes32Bytes32Address(bytes32, bytes32, address);
    event LogBytes32Bytes32Bool(bytes32, bytes32, bool);
    event LogBytes32Bytes32Bytes32(bytes32, bytes32, bytes32);
    event LogBytes32Bytes32Bytes(bytes32, bytes32, bytes);
    event LogBytes32BytesString(bytes32, bytes, string);
    event LogBytes32BytesUint(bytes32, bytes, uint);
    event LogBytes32BytesInt(bytes32, bytes, int);
    event LogBytes32BytesAddress(bytes32, bytes, address);
    event LogBytes32BytesBool(bytes32, bytes, bool);
    event LogBytes32BytesBytes32(bytes32, bytes, bytes32);
    event LogBytes32BytesBytes(bytes32, bytes, bytes);
    event LogBytesStringString(bytes, string, string);
    event LogBytesStringUint(bytes, string, uint);
    event LogBytesStringInt(bytes, string, int);
    event LogBytesStringAddress(bytes, string, address);
    event LogBytesStringBool(bytes, string, bool);
    event LogBytesStringBytes32(bytes, string, bytes32);
    event LogBytesStringBytes(bytes, string, bytes);
    event LogBytesUintString(bytes, uint, string);
    event LogBytesUintUint(bytes, uint, uint);
    event LogBytesUintInt(bytes, uint, int);
    event LogBytesUintAddress(bytes, uint, address);
    event LogBytesUintBool(bytes, uint, bool);
    event LogBytesUintBytes32(bytes, uint, bytes32);
    event LogBytesUintBytes(bytes, uint, bytes);
    event LogBytesIntString(bytes, int, string);
    event LogBytesIntUint(bytes, int, uint);
    event LogBytesIntInt(bytes, int, int);
    event LogBytesIntAddress(bytes, int, address);
    event LogBytesIntBool(bytes, int, bool);
    event LogBytesIntBytes32(bytes, int, bytes32);
    event LogBytesIntBytes(bytes, int, bytes);
    event LogBytesAddressString(bytes, address, string);
    event LogBytesAddressUint(bytes, address, uint);
    event LogBytesAddressInt(bytes, address, int);
    event LogBytesAddressAddress(bytes, address, address);
    event LogBytesAddressBool(bytes, address, bool);
    event LogBytesAddressBytes32(bytes, address, bytes32);
    event LogBytesAddressBytes(bytes, address, bytes);
    event LogBytesBoolString(bytes, bool, string);
    event LogBytesBoolUint(bytes, bool, uint);
    event LogBytesBoolInt(bytes, bool, int);
    event LogBytesBoolAddress(bytes, bool, address);
    event LogBytesBoolBool(bytes, bool, bool);
    event LogBytesBoolBytes32(bytes, bool, bytes32);
    event LogBytesBoolBytes(bytes, bool, bytes);
    event LogBytesBytes32String(bytes, bytes32, string);
    event LogBytesBytes32Uint(bytes, bytes32, uint);
    event LogBytesBytes32Int(bytes, bytes32, int);
    event LogBytesBytes32Address(bytes, bytes32, address);
    event LogBytesBytes32Bool(bytes, bytes32, bool);
    event LogBytesBytes32Bytes32(bytes, bytes32, bytes32);
    event LogBytesBytes32Bytes(bytes, bytes32, bytes);
    event LogBytesBytesString(bytes, bytes, string);
    event LogBytesBytesUint(bytes, bytes, uint);
    event LogBytesBytesInt(bytes, bytes, int);
    event LogBytesBytesAddress(bytes, bytes, address);
    event LogBytesBytesBool(bytes, bytes, bool);
    event LogBytesBytesBytes32(bytes, bytes, bytes32);
    event LogBytesBytesBytes(bytes, bytes, bytes);

    // Single param
    function log(string memory a) internal {
        emit LogString(a);
    }
    function log(uint a) internal {
        emit LogUint(a);
    }
    function log(int a) internal {
        emit LogInt(a);
    }
    function log(address a) internal {
        emit LogAddress(a);
    }
    function log(bool a) internal {
        emit LogBool(a);
    }
    function log(bytes32 a) internal {
        emit LogBytes32(a);
    }
    function log(bytes memory a) internal {
        emit LogBytes(a);
    }

    // Double params
    function log(string memory a, string memory b) internal {
        emit LogStringString(a, b);
    }
    function log(string memory a, uint b) internal {
        emit LogStringUint(a, b);
    }
    function log(string memory a, int b) internal {
        emit LogStringInt(a, b);
    }
    function log(string memory a, address b) internal {
        emit LogStringAddress(a, b);
    }
    function log(string memory a, bool b) internal {
        emit LogStringBool(a, b);
    }
    function log(string memory a, bytes32 b) internal {
        emit LogStringBytes32(a, b);
    }
    function log(string memory a, bytes memory b) internal {
        emit LogStringBytes(a, b);
    }
    function log(uint a, string memory b) internal {
        emit LogUintString(a, b);
    }
    function log(uint a, uint b) internal {
        emit LogUintUint(a, b);
    }
    function log(uint a, int b) internal {
        emit LogUintInt(a, b);
    }
    function log(uint a, address b) internal {
        emit LogUintAddress(a, b);
    }
    function log(uint a, bool b) internal {
        emit LogUintBool(a, b);
    }
    function log(uint a, bytes32 b) internal {
        emit LogUintBytes32(a, b);
    }
    function log(uint a, bytes memory b) internal {
        emit LogUintBytes(a, b);
    }
    function log(int a, string memory b) internal {
        emit LogIntString(a, b);
    }
    function log(int a, uint b) internal {
        emit LogIntUint(a, b);
    }
    function log(int a, int b) internal {
        emit LogIntInt(a, b);
    }
    function log(int a, address b) internal {
        emit LogIntAddress(a, b);
    }
    function log(int a, bool b) internal {
        emit LogIntBool(a, b);
    }
    function log(int a, bytes32 b) internal {
        emit LogIntBytes32(a, b);
    }
    function log(int a, bytes memory b) internal {
        emit LogIntBytes(a, b);
    }
    function log(address a, string memory b) internal {
        emit LogAddressString(a, b);
    }
    function log(address a, uint b) internal {
        emit LogAddressUint(a, b);
    }
    function log(address a, int b) internal {
        emit LogAddressInt(a, b);
    }
    function log(address a, address b) internal {
        emit LogAddressAddress(a, b);
    }
    function log(address a, bool b) internal {
        emit LogAddressBool(a, b);
    }
    function log(address a, bytes32 b) internal {
        emit LogAddressBytes32(a, b);
    }
    function log(address a, bytes memory b) internal {
        emit LogAddressBytes(a, b);
    }
    function log(bool a, string memory b) internal {
        emit LogBoolString(a, b);
    }
    function log(bool a, uint b) internal {
        emit LogBoolUint(a, b);
    }
    function log(bool a, int b) internal {
        emit LogBoolInt(a, b);
    }
    function log(bool a, address b) internal {
        emit LogBoolAddress(a, b);
    }
    function log(bool a, bool b) internal {
        emit LogBoolBool(a, b);
    }
    function log(bool a, bytes32 b) internal {
        emit LogBoolBytes32(a, b);
    }
    function log(bool a, bytes memory b) internal {
        emit LogBoolBytes(a, b);
    }
    function log(bytes32 a, string memory b) internal {
        emit LogBytes32String(a, b);
    }
    function log(bytes32 a, uint b) internal {
        emit LogBytes32Uint(a, b);
    }
    function log(bytes32 a, int b) internal {
        emit LogBytes32Int(a, b);
    }
    function log(bytes32 a, address b) internal {
        emit LogBytes32Address(a, b);
    }
    function log(bytes32 a, bool b) internal {
        emit LogBytes32Bool(a, b);
    }
    function log(bytes32 a, bytes32 b) internal {
        emit LogBytes32Bytes32(a, b);
    }
    function log(bytes32 a, bytes memory b) internal {
        emit LogBytes32Bytes(a, b);
    }
    function log(bytes memory a, string memory b) internal {
        emit LogBytesString(a, b);
    }
    function log(bytes memory a, uint b) internal {
        emit LogBytesUint(a, b);
    }
    function log(bytes memory a, int b) internal {
        emit LogBytesInt(a, b);
    }
    function log(bytes memory a, address b) internal {
        emit LogBytesAddress(a, b);
    }
    function log(bytes memory a, bool b) internal {
        emit LogBytesBool(a, b);
    }
    function log(bytes memory a, bytes32 b) internal {
        emit LogBytesBytes32(a, b);
    }
    function log(bytes memory a, bytes memory b) internal {
        emit LogBytesBytes(a, b);
    }

    // Triple params
    function log(string memory a, string memory b, string memory c) internal {
        emit LogStringStringString(a, b, c);
    }
    function log(string memory a, string memory b, uint c) internal {
        emit LogStringStringUint(a, b, c);
    }
    function log(string memory a, string memory b, int c) internal {
        emit LogStringStringInt(a, b, c);
    }
    function log(string memory a, string memory b, address c) internal {
        emit LogStringStringAddress(a, b, c);
    }
    function log(string memory a, string memory b, bool c) internal {
        emit LogStringStringBool(a, b, c);
    }
    function log(string memory a, string memory b, bytes32 c) internal {
        emit LogStringStringBytes32(a, b, c);
    }
    function log(string memory a, string memory b, bytes memory c) internal {
        emit LogStringStringBytes(a, b, c);
    }
    function log(string memory a, uint b, string memory c) internal {
        emit LogStringUintString(a, b, c);
    }
    function log(string memory a, uint b, uint c) internal {
        emit LogStringUintUint(a, b, c);
    }
    function log(string memory a, uint b, int c) internal {
        emit LogStringUintInt(a, b, c);
    }
    function log(string memory a, uint b, address c) internal {
        emit LogStringUintAddress(a, b, c);
    }
    function log(string memory a, uint b, bool c) internal {
        emit LogStringUintBool(a, b, c);
    }
    function log(string memory a, uint b, bytes32 c) internal {
        emit LogStringUintBytes32(a, b, c);
    }
    function log(string memory a, uint b, bytes memory c) internal {
        emit LogStringUintBytes(a, b, c);
    }
    function log(string memory a, int b, string memory c) internal {
        emit LogStringIntString(a, b, c);
    }
    function log(string memory a, int b, uint c) internal {
        emit LogStringIntUint(a, b, c);
    }
    function log(string memory a, int b, int c) internal {
        emit LogStringIntInt(a, b, c);
    }
    function log(string memory a, int b, address c) internal {
        emit LogStringIntAddress(a, b, c);
    }
    function log(string memory a, int b, bool c) internal {
        emit LogStringIntBool(a, b, c);
    }
    function log(string memory a, int b, bytes32 c) internal {
        emit LogStringIntBytes32(a, b, c);
    }
    function log(string memory a, int b, bytes memory c) internal {
        emit LogStringIntBytes(a, b, c);
    }
    function log(string memory a, address b, string memory c) internal {
        emit LogStringAddressString(a, b, c);
    }
    function log(string memory a, address b, uint c) internal {
        emit LogStringAddressUint(a, b, c);
    }
    function log(string memory a, address b, int c) internal {
        emit LogStringAddressInt(a, b, c);
    }
    function log(string memory a, address b, address c) internal {
        emit LogStringAddressAddress(a, b, c);
    }
    function log(string memory a, address b, bool c) internal {
        emit LogStringAddressBool(a, b, c);
    }
    function log(string memory a, address b, bytes32 c) internal {
        emit LogStringAddressBytes32(a, b, c);
    }
    function log(string memory a, address b, bytes memory c) internal {
        emit LogStringAddressBytes(a, b, c);
    }
    function log(string memory a, bool b, string memory c) internal {
        emit LogStringBoolString(a, b, c);
    }
    function log(string memory a, bool b, uint c) internal {
        emit LogStringBoolUint(a, b, c);
    }
    function log(string memory a, bool b, int c) internal {
        emit LogStringBoolInt(a, b, c);
    }
    function log(string memory a, bool b, address c) internal {
        emit LogStringBoolAddress(a, b, c);
    }
    function log(string memory a, bool b, bool c) internal {
        emit LogStringBoolBool(a, b, c);
    }
    function log(string memory a, bool b, bytes32 c) internal {
        emit LogStringBoolBytes32(a, b, c);
    }
    function log(string memory a, bool b, bytes memory c) internal {
        emit LogStringBoolBytes(a, b, c);
    }
    function log(string memory a, bytes32 b, string memory c) internal {
        emit LogStringBytes32String(a, b, c);
    }
    function log(string memory a, bytes32 b, uint c) internal {
        emit LogStringBytes32Uint(a, b, c);
    }
    function log(string memory a, bytes32 b, int c) internal {
        emit LogStringBytes32Int(a, b, c);
    }
    function log(string memory a, bytes32 b, address c) internal {
        emit LogStringBytes32Address(a, b, c);
    }
    function log(string memory a, bytes32 b, bool c) internal {
        emit LogStringBytes32Bool(a, b, c);
    }
    function log(string memory a, bytes32 b, bytes32 c) internal {
        emit LogStringBytes32Bytes32(a, b, c);
    }
    function log(string memory a, bytes32 b, bytes memory c) internal {
        emit LogStringBytes32Bytes(a, b, c);
    }
    function log(string memory a, bytes memory b, string memory c) internal {
        emit LogStringBytesString(a, b, c);
    }
    function log(string memory a, bytes memory b, uint c) internal {
        emit LogStringBytesUint(a, b, c);
    }
    function log(string memory a, bytes memory b, int c) internal {
        emit LogStringBytesInt(a, b, c);
    }
    function log(string memory a, bytes memory b, address c) internal {
        emit LogStringBytesAddress(a, b, c);
    }
    function log(string memory a, bytes memory b, bool c) internal {
        emit LogStringBytesBool(a, b, c);
    }
    function log(string memory a, bytes memory b, bytes32 c) internal {
        emit LogStringBytesBytes32(a, b, c);
    }
    function log(string memory a, bytes memory b, bytes memory c) internal {
        emit LogStringBytesBytes(a, b, c);
    }
    function log(uint a, string memory b, string memory c) internal {
        emit LogUintStringString(a, b, c);
    }
    function log(uint a, string memory b, uint c) internal {
        emit LogUintStringUint(a, b, c);
    }
    function log(uint a, string memory b, int c) internal {
        emit LogUintStringInt(a, b, c);
    }
    function log(uint a, string memory b, address c) internal {
        emit LogUintStringAddress(a, b, c);
    }
    function log(uint a, string memory b, bool c) internal {
        emit LogUintStringBool(a, b, c);
    }
    function log(uint a, string memory b, bytes32 c) internal {
        emit LogUintStringBytes32(a, b, c);
    }
    function log(uint a, string memory b, bytes memory c) internal {
        emit LogUintStringBytes(a, b, c);
    }
    function log(uint a, uint b, string memory c) internal {
        emit LogUintUintString(a, b, c);
    }
    function log(uint a, uint b, uint c) internal {
        emit LogUintUintUint(a, b, c);
    }
    function log(uint a, uint b, int c) internal {
        emit LogUintUintInt(a, b, c);
    }
    function log(uint a, uint b, address c) internal {
        emit LogUintUintAddress(a, b, c);
    }
    function log(uint a, uint b, bool c) internal {
        emit LogUintUintBool(a, b, c);
    }
    function log(uint a, uint b, bytes32 c) internal {
        emit LogUintUintBytes32(a, b, c);
    }
    function log(uint a, uint b, bytes memory c) internal {
        emit LogUintUintBytes(a, b, c);
    }
    function log(uint a, int b, string memory c) internal {
        emit LogUintIntString(a, b, c);
    }
    function log(uint a, int b, uint c) internal {
        emit LogUintIntUint(a, b, c);
    }
    function log(uint a, int b, int c) internal {
        emit LogUintIntInt(a, b, c);
    }
    function log(uint a, int b, address c) internal {
        emit LogUintIntAddress(a, b, c);
    }
    function log(uint a, int b, bool c) internal {
        emit LogUintIntBool(a, b, c);
    }
    function log(uint a, int b, bytes32 c) internal {
        emit LogUintIntBytes32(a, b, c);
    }
    function log(uint a, int b, bytes memory c) internal {
        emit LogUintIntBytes(a, b, c);
    }
    function log(uint a, address b, string memory c) internal {
        emit LogUintAddressString(a, b, c);
    }
    function log(uint a, address b, uint c) internal {
        emit LogUintAddressUint(a, b, c);
    }
    function log(uint a, address b, int c) internal {
        emit LogUintAddressInt(a, b, c);
    }
    function log(uint a, address b, address c) internal {
        emit LogUintAddressAddress(a, b, c);
    }
    function log(uint a, address b, bool c) internal {
        emit LogUintAddressBool(a, b, c);
    }
    function log(uint a, address b, bytes32 c) internal {
        emit LogUintAddressBytes32(a, b, c);
    }
    function log(uint a, address b, bytes memory c) internal {
        emit LogUintAddressBytes(a, b, c);
    }
    function log(uint a, bool b, string memory c) internal {
        emit LogUintBoolString(a, b, c);
    }
    function log(uint a, bool b, uint c) internal {
        emit LogUintBoolUint(a, b, c);
    }
    function log(uint a, bool b, int c) internal {
        emit LogUintBoolInt(a, b, c);
    }
    function log(uint a, bool b, address c) internal {
        emit LogUintBoolAddress(a, b, c);
    }
    function log(uint a, bool b, bool c) internal {
        emit LogUintBoolBool(a, b, c);
    }
    function log(uint a, bool b, bytes32 c) internal {
        emit LogUintBoolBytes32(a, b, c);
    }
    function log(uint a, bool b, bytes memory c) internal {
        emit LogUintBoolBytes(a, b, c);
    }
    function log(uint a, bytes32 b, string memory c) internal {
        emit LogUintBytes32String(a, b, c);
    }
    function log(uint a, bytes32 b, uint c) internal {
        emit LogUintBytes32Uint(a, b, c);
    }
    function log(uint a, bytes32 b, int c) internal {
        emit LogUintBytes32Int(a, b, c);
    }
    function log(uint a, bytes32 b, address c) internal {
        emit LogUintBytes32Address(a, b, c);
    }
    function log(uint a, bytes32 b, bool c) internal {
        emit LogUintBytes32Bool(a, b, c);
    }
    function log(uint a, bytes32 b, bytes32 c) internal {
        emit LogUintBytes32Bytes32(a, b, c);
    }
    function log(uint a, bytes32 b, bytes memory c) internal {
        emit LogUintBytes32Bytes(a, b, c);
    }
    function log(uint a, bytes memory b, string memory c) internal {
        emit LogUintBytesString(a, b, c);
    }
    function log(uint a, bytes memory b, uint c) internal {
        emit LogUintBytesUint(a, b, c);
    }
    function log(uint a, bytes memory b, int c) internal {
        emit LogUintBytesInt(a, b, c);
    }
    function log(uint a, bytes memory b, address c) internal {
        emit LogUintBytesAddress(a, b, c);
    }
    function log(uint a, bytes memory b, bool c) internal {
        emit LogUintBytesBool(a, b, c);
    }
    function log(uint a, bytes memory b, bytes32 c) internal {
        emit LogUintBytesBytes32(a, b, c);
    }
    function log(uint a, bytes memory b, bytes memory c) internal {
        emit LogUintBytesBytes(a, b, c);
    }
    function log(int a, string memory b, string memory c) internal {
        emit LogIntStringString(a, b, c);
    }
    function log(int a, string memory b, uint c) internal {
        emit LogIntStringUint(a, b, c);
    }
    function log(int a, string memory b, int c) internal {
        emit LogIntStringInt(a, b, c);
    }
    function log(int a, string memory b, address c) internal {
        emit LogIntStringAddress(a, b, c);
    }
    function log(int a, string memory b, bool c) internal {
        emit LogIntStringBool(a, b, c);
    }
    function log(int a, string memory b, bytes32 c) internal {
        emit LogIntStringBytes32(a, b, c);
    }
    function log(int a, string memory b, bytes memory c) internal {
        emit LogIntStringBytes(a, b, c);
    }
    function log(int a, uint b, string memory c) internal {
        emit LogIntUintString(a, b, c);
    }
    function log(int a, uint b, uint c) internal {
        emit LogIntUintUint(a, b, c);
    }
    function log(int a, uint b, int c) internal {
        emit LogIntUintInt(a, b, c);
    }
    function log(int a, uint b, address c) internal {
        emit LogIntUintAddress(a, b, c);
    }
    function log(int a, uint b, bool c) internal {
        emit LogIntUintBool(a, b, c);
    }
    function log(int a, uint b, bytes32 c) internal {
        emit LogIntUintBytes32(a, b, c);
    }
    function log(int a, uint b, bytes memory c) internal {
        emit LogIntUintBytes(a, b, c);
    }
    function log(int a, int b, string memory c) internal {
        emit LogIntIntString(a, b, c);
    }
    function log(int a, int b, uint c) internal {
        emit LogIntIntUint(a, b, c);
    }
    function log(int a, int b, int c) internal {
        emit LogIntIntInt(a, b, c);
    }
    function log(int a, int b, address c) internal {
        emit LogIntIntAddress(a, b, c);
    }
    function log(int a, int b, bool c) internal {
        emit LogIntIntBool(a, b, c);
    }
    function log(int a, int b, bytes32 c) internal {
        emit LogIntIntBytes32(a, b, c);
    }
    function log(int a, int b, bytes memory c) internal {
        emit LogIntIntBytes(a, b, c);
    }
    function log(int a, address b, string memory c) internal {
        emit LogIntAddressString(a, b, c);
    }
    function log(int a, address b, uint c) internal {
        emit LogIntAddressUint(a, b, c);
    }
    function log(int a, address b, int c) internal {
        emit LogIntAddressInt(a, b, c);
    }
    function log(int a, address b, address c) internal {
        emit LogIntAddressAddress(a, b, c);
    }
    function log(int a, address b, bool c) internal {
        emit LogIntAddressBool(a, b, c);
    }
    function log(int a, address b, bytes32 c) internal {
        emit LogIntAddressBytes32(a, b, c);
    }
    function log(int a, address b, bytes memory c) internal {
        emit LogIntAddressBytes(a, b, c);
    }
    function log(int a, bool b, string memory c) internal {
        emit LogIntBoolString(a, b, c);
    }
    function log(int a, bool b, uint c) internal {
        emit LogIntBoolUint(a, b, c);
    }
    function log(int a, bool b, int c) internal {
        emit LogIntBoolInt(a, b, c);
    }
    function log(int a, bool b, address c) internal {
        emit LogIntBoolAddress(a, b, c);
    }
    function log(int a, bool b, bool c) internal {
        emit LogIntBoolBool(a, b, c);
    }
    function log(int a, bool b, bytes32 c) internal {
        emit LogIntBoolBytes32(a, b, c);
    }
    function log(int a, bool b, bytes memory c) internal {
        emit LogIntBoolBytes(a, b, c);
    }
    function log(int a, bytes32 b, string memory c) internal {
        emit LogIntBytes32String(a, b, c);
    }
    function log(int a, bytes32 b, uint c) internal {
        emit LogIntBytes32Uint(a, b, c);
    }
    function log(int a, bytes32 b, int c) internal {
        emit LogIntBytes32Int(a, b, c);
    }
    function log(int a, bytes32 b, address c) internal {
        emit LogIntBytes32Address(a, b, c);
    }
    function log(int a, bytes32 b, bool c) internal {
        emit LogIntBytes32Bool(a, b, c);
    }
    function log(int a, bytes32 b, bytes32 c) internal {
        emit LogIntBytes32Bytes32(a, b, c);
    }
    function log(int a, bytes32 b, bytes memory c) internal {
        emit LogIntBytes32Bytes(a, b, c);
    }
    function log(int a, bytes memory b, string memory c) internal {
        emit LogIntBytesString(a, b, c);
    }
    function log(int a, bytes memory b, uint c) internal {
        emit LogIntBytesUint(a, b, c);
    }
    function log(int a, bytes memory b, int c) internal {
        emit LogIntBytesInt(a, b, c);
    }
    function log(int a, bytes memory b, address c) internal {
        emit LogIntBytesAddress(a, b, c);
    }
    function log(int a, bytes memory b, bool c) internal {
        emit LogIntBytesBool(a, b, c);
    }
    function log(int a, bytes memory b, bytes32 c) internal {
        emit LogIntBytesBytes32(a, b, c);
    }
    function log(int a, bytes memory b, bytes memory c) internal {
        emit LogIntBytesBytes(a, b, c);
    }
    function log(address a, string memory b, string memory c) internal {
        emit LogAddressStringString(a, b, c);
    }
    function log(address a, string memory b, uint c) internal {
        emit LogAddressStringUint(a, b, c);
    }
    function log(address a, string memory b, int c) internal {
        emit LogAddressStringInt(a, b, c);
    }
    function log(address a, string memory b, address c) internal {
        emit LogAddressStringAddress(a, b, c);
    }
    function log(address a, string memory b, bool c) internal {
        emit LogAddressStringBool(a, b, c);
    }
    function log(address a, string memory b, bytes32 c) internal {
        emit LogAddressStringBytes32(a, b, c);
    }
    function log(address a, string memory b, bytes memory c) internal {
        emit LogAddressStringBytes(a, b, c);
    }
    function log(address a, uint b, string memory c) internal {
        emit LogAddressUintString(a, b, c);
    }
    function log(address a, uint b, uint c) internal {
        emit LogAddressUintUint(a, b, c);
    }
    function log(address a, uint b, int c) internal {
        emit LogAddressUintInt(a, b, c);
    }
    function log(address a, uint b, address c) internal {
        emit LogAddressUintAddress(a, b, c);
    }
    function log(address a, uint b, bool c) internal {
        emit LogAddressUintBool(a, b, c);
    }
    function log(address a, uint b, bytes32 c) internal {
        emit LogAddressUintBytes32(a, b, c);
    }
    function log(address a, uint b, bytes memory c) internal {
        emit LogAddressUintBytes(a, b, c);
    }
    function log(address a, int b, string memory c) internal {
        emit LogAddressIntString(a, b, c);
    }
    function log(address a, int b, uint c) internal {
        emit LogAddressIntUint(a, b, c);
    }
    function log(address a, int b, int c) internal {
        emit LogAddressIntInt(a, b, c);
    }
    function log(address a, int b, address c) internal {
        emit LogAddressIntAddress(a, b, c);
    }
    function log(address a, int b, bool c) internal {
        emit LogAddressIntBool(a, b, c);
    }
    function log(address a, int b, bytes32 c) internal {
        emit LogAddressIntBytes32(a, b, c);
    }
    function log(address a, int b, bytes memory c) internal {
        emit LogAddressIntBytes(a, b, c);
    }
    function log(address a, address b, string memory c) internal {
        emit LogAddressAddressString(a, b, c);
    }
    function log(address a, address b, uint c) internal {
        emit LogAddressAddressUint(a, b, c);
    }
    function log(address a, address b, int c) internal {
        emit LogAddressAddressInt(a, b, c);
    }
    function log(address a, address b, address c) internal {
        emit LogAddressAddressAddress(a, b, c);
    }
    function log(address a, address b, bool c) internal {
        emit LogAddressAddressBool(a, b, c);
    }
    function log(address a, address b, bytes32 c) internal {
        emit LogAddressAddressBytes32(a, b, c);
    }
    function log(address a, address b, bytes memory c) internal {
        emit LogAddressAddressBytes(a, b, c);
    }
    function log(address a, bool b, string memory c) internal {
        emit LogAddressBoolString(a, b, c);
    }
    function log(address a, bool b, uint c) internal {
        emit LogAddressBoolUint(a, b, c);
    }
    function log(address a, bool b, int c) internal {
        emit LogAddressBoolInt(a, b, c);
    }
    function log(address a, bool b, address c) internal {
        emit LogAddressBoolAddress(a, b, c);
    }
    function log(address a, bool b, bool c) internal {
        emit LogAddressBoolBool(a, b, c);
    }
    function log(address a, bool b, bytes32 c) internal {
        emit LogAddressBoolBytes32(a, b, c);
    }
    function log(address a, bool b, bytes memory c) internal {
        emit LogAddressBoolBytes(a, b, c);
    }
    function log(address a, bytes32 b, string memory c) internal {
        emit LogAddressBytes32String(a, b, c);
    }
    function log(address a, bytes32 b, uint c) internal {
        emit LogAddressBytes32Uint(a, b, c);
    }
    function log(address a, bytes32 b, int c) internal {
        emit LogAddressBytes32Int(a, b, c);
    }
    function log(address a, bytes32 b, address c) internal {
        emit LogAddressBytes32Address(a, b, c);
    }
    function log(address a, bytes32 b, bool c) internal {
        emit LogAddressBytes32Bool(a, b, c);
    }
    function log(address a, bytes32 b, bytes32 c) internal {
        emit LogAddressBytes32Bytes32(a, b, c);
    }
    function log(address a, bytes32 b, bytes memory c) internal {
        emit LogAddressBytes32Bytes(a, b, c);
    }
    function log(address a, bytes memory b, string memory c) internal {
        emit LogAddressBytesString(a, b, c);
    }
    function log(address a, bytes memory b, uint c) internal {
        emit LogAddressBytesUint(a, b, c);
    }
    function log(address a, bytes memory b, int c) internal {
        emit LogAddressBytesInt(a, b, c);
    }
    function log(address a, bytes memory b, address c) internal {
        emit LogAddressBytesAddress(a, b, c);
    }
    function log(address a, bytes memory b, bool c) internal {
        emit LogAddressBytesBool(a, b, c);
    }
    function log(address a, bytes memory b, bytes32 c) internal {
        emit LogAddressBytesBytes32(a, b, c);
    }
    function log(address a, bytes memory b, bytes memory c) internal {
        emit LogAddressBytesBytes(a, b, c);
    }
    function log(bool a, string memory b, string memory c) internal {
        emit LogBoolStringString(a, b, c);
    }
    function log(bool a, string memory b, uint c) internal {
        emit LogBoolStringUint(a, b, c);
    }
    function log(bool a, string memory b, int c) internal {
        emit LogBoolStringInt(a, b, c);
    }
    function log(bool a, string memory b, address c) internal {
        emit LogBoolStringAddress(a, b, c);
    }
    function log(bool a, string memory b, bool c) internal {
        emit LogBoolStringBool(a, b, c);
    }
    function log(bool a, string memory b, bytes32 c) internal {
        emit LogBoolStringBytes32(a, b, c);
    }
    function log(bool a, string memory b, bytes memory c) internal {
        emit LogBoolStringBytes(a, b, c);
    }
    function log(bool a, uint b, string memory c) internal {
        emit LogBoolUintString(a, b, c);
    }
    function log(bool a, uint b, uint c) internal {
        emit LogBoolUintUint(a, b, c);
    }
    function log(bool a, uint b, int c) internal {
        emit LogBoolUintInt(a, b, c);
    }
    function log(bool a, uint b, address c) internal {
        emit LogBoolUintAddress(a, b, c);
    }
    function log(bool a, uint b, bool c) internal {
        emit LogBoolUintBool(a, b, c);
    }
    function log(bool a, uint b, bytes32 c) internal {
        emit LogBoolUintBytes32(a, b, c);
    }
    function log(bool a, uint b, bytes memory c) internal {
        emit LogBoolUintBytes(a, b, c);
    }
    function log(bool a, int b, string memory c) internal {
        emit LogBoolIntString(a, b, c);
    }
    function log(bool a, int b, uint c) internal {
        emit LogBoolIntUint(a, b, c);
    }
    function log(bool a, int b, int c) internal {
        emit LogBoolIntInt(a, b, c);
    }
    function log(bool a, int b, address c) internal {
        emit LogBoolIntAddress(a, b, c);
    }
    function log(bool a, int b, bool c) internal {
        emit LogBoolIntBool(a, b, c);
    }
    function log(bool a, int b, bytes32 c) internal {
        emit LogBoolIntBytes32(a, b, c);
    }
    function log(bool a, int b, bytes memory c) internal {
        emit LogBoolIntBytes(a, b, c);
    }
    function log(bool a, address b, string memory c) internal {
        emit LogBoolAddressString(a, b, c);
    }
    function log(bool a, address b, uint c) internal {
        emit LogBoolAddressUint(a, b, c);
    }
    function log(bool a, address b, int c) internal {
        emit LogBoolAddressInt(a, b, c);
    }
    function log(bool a, address b, address c) internal {
        emit LogBoolAddressAddress(a, b, c);
    }
    function log(bool a, address b, bool c) internal {
        emit LogBoolAddressBool(a, b, c);
    }
    function log(bool a, address b, bytes32 c) internal {
        emit LogBoolAddressBytes32(a, b, c);
    }
    function log(bool a, address b, bytes memory c) internal {
        emit LogBoolAddressBytes(a, b, c);
    }
    function log(bool a, bool b, string memory c) internal {
        emit LogBoolBoolString(a, b, c);
    }
    function log(bool a, bool b, uint c) internal {
        emit LogBoolBoolUint(a, b, c);
    }
    function log(bool a, bool b, int c) internal {
        emit LogBoolBoolInt(a, b, c);
    }
    function log(bool a, bool b, address c) internal {
        emit LogBoolBoolAddress(a, b, c);
    }
    function log(bool a, bool b, bool c) internal {
        emit LogBoolBoolBool(a, b, c);
    }
    function log(bool a, bool b, bytes32 c) internal {
        emit LogBoolBoolBytes32(a, b, c);
    }
    function log(bool a, bool b, bytes memory c) internal {
        emit LogBoolBoolBytes(a, b, c);
    }
    function log(bool a, bytes32 b, string memory c) internal {
        emit LogBoolBytes32String(a, b, c);
    }
    function log(bool a, bytes32 b, uint c) internal {
        emit LogBoolBytes32Uint(a, b, c);
    }
    function log(bool a, bytes32 b, int c) internal {
        emit LogBoolBytes32Int(a, b, c);
    }
    function log(bool a, bytes32 b, address c) internal {
        emit LogBoolBytes32Address(a, b, c);
    }
    function log(bool a, bytes32 b, bool c) internal {
        emit LogBoolBytes32Bool(a, b, c);
    }
    function log(bool a, bytes32 b, bytes32 c) internal {
        emit LogBoolBytes32Bytes32(a, b, c);
    }
    function log(bool a, bytes32 b, bytes memory c) internal {
        emit LogBoolBytes32Bytes(a, b, c);
    }
    function log(bool a, bytes memory b, string memory c) internal {
        emit LogBoolBytesString(a, b, c);
    }
    function log(bool a, bytes memory b, uint c) internal {
        emit LogBoolBytesUint(a, b, c);
    }
    function log(bool a, bytes memory b, int c) internal {
        emit LogBoolBytesInt(a, b, c);
    }
    function log(bool a, bytes memory b, address c) internal {
        emit LogBoolBytesAddress(a, b, c);
    }
    function log(bool a, bytes memory b, bool c) internal {
        emit LogBoolBytesBool(a, b, c);
    }
    function log(bool a, bytes memory b, bytes32 c) internal {
        emit LogBoolBytesBytes32(a, b, c);
    }
    function log(bool a, bytes memory b, bytes memory c) internal {
        emit LogBoolBytesBytes(a, b, c);
    }
    function log(bytes32 a, string memory b, string memory c) internal {
        emit LogBytes32StringString(a, b, c);
    }
    function log(bytes32 a, string memory b, uint c) internal {
        emit LogBytes32StringUint(a, b, c);
    }
    function log(bytes32 a, string memory b, int c) internal {
        emit LogBytes32StringInt(a, b, c);
    }
    function log(bytes32 a, string memory b, address c) internal {
        emit LogBytes32StringAddress(a, b, c);
    }
    function log(bytes32 a, string memory b, bool c) internal {
        emit LogBytes32StringBool(a, b, c);
    }
    function log(bytes32 a, string memory b, bytes32 c) internal {
        emit LogBytes32StringBytes32(a, b, c);
    }
    function log(bytes32 a, string memory b, bytes memory c) internal {
        emit LogBytes32StringBytes(a, b, c);
    }
    function log(bytes32 a, uint b, string memory c) internal {
        emit LogBytes32UintString(a, b, c);
    }
    function log(bytes32 a, uint b, uint c) internal {
        emit LogBytes32UintUint(a, b, c);
    }
    function log(bytes32 a, uint b, int c) internal {
        emit LogBytes32UintInt(a, b, c);
    }
    function log(bytes32 a, uint b, address c) internal {
        emit LogBytes32UintAddress(a, b, c);
    }
    function log(bytes32 a, uint b, bool c) internal {
        emit LogBytes32UintBool(a, b, c);
    }
    function log(bytes32 a, uint b, bytes32 c) internal {
        emit LogBytes32UintBytes32(a, b, c);
    }
    function log(bytes32 a, uint b, bytes memory c) internal {
        emit LogBytes32UintBytes(a, b, c);
    }
    function log(bytes32 a, int b, string memory c) internal {
        emit LogBytes32IntString(a, b, c);
    }
    function log(bytes32 a, int b, uint c) internal {
        emit LogBytes32IntUint(a, b, c);
    }
    function log(bytes32 a, int b, int c) internal {
        emit LogBytes32IntInt(a, b, c);
    }
    function log(bytes32 a, int b, address c) internal {
        emit LogBytes32IntAddress(a, b, c);
    }
    function log(bytes32 a, int b, bool c) internal {
        emit LogBytes32IntBool(a, b, c);
    }
    function log(bytes32 a, int b, bytes32 c) internal {
        emit LogBytes32IntBytes32(a, b, c);
    }
    function log(bytes32 a, int b, bytes memory c) internal {
        emit LogBytes32IntBytes(a, b, c);
    }
    function log(bytes32 a, address b, string memory c) internal {
        emit LogBytes32AddressString(a, b, c);
    }
    function log(bytes32 a, address b, uint c) internal {
        emit LogBytes32AddressUint(a, b, c);
    }
    function log(bytes32 a, address b, int c) internal {
        emit LogBytes32AddressInt(a, b, c);
    }
    function log(bytes32 a, address b, address c) internal {
        emit LogBytes32AddressAddress(a, b, c);
    }
    function log(bytes32 a, address b, bool c) internal {
        emit LogBytes32AddressBool(a, b, c);
    }
    function log(bytes32 a, address b, bytes32 c) internal {
        emit LogBytes32AddressBytes32(a, b, c);
    }
    function log(bytes32 a, address b, bytes memory c) internal {
        emit LogBytes32AddressBytes(a, b, c);
    }
    function log(bytes32 a, bool b, string memory c) internal {
        emit LogBytes32BoolString(a, b, c);
    }
    function log(bytes32 a, bool b, uint c) internal {
        emit LogBytes32BoolUint(a, b, c);
    }
    function log(bytes32 a, bool b, int c) internal {
        emit LogBytes32BoolInt(a, b, c);
    }
    function log(bytes32 a, bool b, address c) internal {
        emit LogBytes32BoolAddress(a, b, c);
    }
    function log(bytes32 a, bool b, bool c) internal {
        emit LogBytes32BoolBool(a, b, c);
    }
    function log(bytes32 a, bool b, bytes32 c) internal {
        emit LogBytes32BoolBytes32(a, b, c);
    }
    function log(bytes32 a, bool b, bytes memory c) internal {
        emit LogBytes32BoolBytes(a, b, c);
    }
    function log(bytes32 a, bytes32 b, string memory c) internal {
        emit LogBytes32Bytes32String(a, b, c);
    }
    function log(bytes32 a, bytes32 b, uint c) internal {
        emit LogBytes32Bytes32Uint(a, b, c);
    }
    function log(bytes32 a, bytes32 b, int c) internal {
        emit LogBytes32Bytes32Int(a, b, c);
    }
    function log(bytes32 a, bytes32 b, address c) internal {
        emit LogBytes32Bytes32Address(a, b, c);
    }
    function log(bytes32 a, bytes32 b, bool c) internal {
        emit LogBytes32Bytes32Bool(a, b, c);
    }
    function log(bytes32 a, bytes32 b, bytes32 c) internal {
        emit LogBytes32Bytes32Bytes32(a, b, c);
    }
    function log(bytes32 a, bytes32 b, bytes memory c) internal {
        emit LogBytes32Bytes32Bytes(a, b, c);
    }
    function log(bytes32 a, bytes memory b, string memory c) internal {
        emit LogBytes32BytesString(a, b, c);
    }
    function log(bytes32 a, bytes memory b, uint c) internal {
        emit LogBytes32BytesUint(a, b, c);
    }
    function log(bytes32 a, bytes memory b, int c) internal {
        emit LogBytes32BytesInt(a, b, c);
    }
    function log(bytes32 a, bytes memory b, address c) internal {
        emit LogBytes32BytesAddress(a, b, c);
    }
    function log(bytes32 a, bytes memory b, bool c) internal {
        emit LogBytes32BytesBool(a, b, c);
    }
    function log(bytes32 a, bytes memory b, bytes32 c) internal {
        emit LogBytes32BytesBytes32(a, b, c);
    }
    function log(bytes32 a, bytes memory b, bytes memory c) internal {
        emit LogBytes32BytesBytes(a, b, c);
    }
    function log(bytes memory a, string memory b, string memory c) internal {
        emit LogBytesStringString(a, b, c);
    }
    function log(bytes memory a, string memory b, uint c) internal {
        emit LogBytesStringUint(a, b, c);
    }
    function log(bytes memory a, string memory b, int c) internal {
        emit LogBytesStringInt(a, b, c);
    }
    function log(bytes memory a, string memory b, address c) internal {
        emit LogBytesStringAddress(a, b, c);
    }
    function log(bytes memory a, string memory b, bool c) internal {
        emit LogBytesStringBool(a, b, c);
    }
    function log(bytes memory a, string memory b, bytes32 c) internal {
        emit LogBytesStringBytes32(a, b, c);
    }
    function log(bytes memory a, string memory b, bytes memory c) internal {
        emit LogBytesStringBytes(a, b, c);
    }
    function log(bytes memory a, uint b, string memory c) internal {
        emit LogBytesUintString(a, b, c);
    }
    function log(bytes memory a, uint b, uint c) internal {
        emit LogBytesUintUint(a, b, c);
    }
    function log(bytes memory a, uint b, int c) internal {
        emit LogBytesUintInt(a, b, c);
    }
    function log(bytes memory a, uint b, address c) internal {
        emit LogBytesUintAddress(a, b, c);
    }
    function log(bytes memory a, uint b, bool c) internal {
        emit LogBytesUintBool(a, b, c);
    }
    function log(bytes memory a, uint b, bytes32 c) internal {
        emit LogBytesUintBytes32(a, b, c);
    }
    function log(bytes memory a, uint b, bytes memory c) internal {
        emit LogBytesUintBytes(a, b, c);
    }
    function log(bytes memory a, int b, string memory c) internal {
        emit LogBytesIntString(a, b, c);
    }
    function log(bytes memory a, int b, uint c) internal {
        emit LogBytesIntUint(a, b, c);
    }
    function log(bytes memory a, int b, int c) internal {
        emit LogBytesIntInt(a, b, c);
    }
    function log(bytes memory a, int b, address c) internal {
        emit LogBytesIntAddress(a, b, c);
    }
    function log(bytes memory a, int b, bool c) internal {
        emit LogBytesIntBool(a, b, c);
    }
    function log(bytes memory a, int b, bytes32 c) internal {
        emit LogBytesIntBytes32(a, b, c);
    }
    function log(bytes memory a, int b, bytes memory c) internal {
        emit LogBytesIntBytes(a, b, c);
    }
    function log(bytes memory a, address b, string memory c) internal {
        emit LogBytesAddressString(a, b, c);
    }
    function log(bytes memory a, address b, uint c) internal {
        emit LogBytesAddressUint(a, b, c);
    }
    function log(bytes memory a, address b, int c) internal {
        emit LogBytesAddressInt(a, b, c);
    }
    function log(bytes memory a, address b, address c) internal {
        emit LogBytesAddressAddress(a, b, c);
    }
    function log(bytes memory a, address b, bool c) internal {
        emit LogBytesAddressBool(a, b, c);
    }
    function log(bytes memory a, address b, bytes32 c) internal {
        emit LogBytesAddressBytes32(a, b, c);
    }
    function log(bytes memory a, address b, bytes memory c) internal {
        emit LogBytesAddressBytes(a, b, c);
    }
    function log(bytes memory a, bool b, string memory c) internal {
        emit LogBytesBoolString(a, b, c);
    }
    function log(bytes memory a, bool b, uint c) internal {
        emit LogBytesBoolUint(a, b, c);
    }
    function log(bytes memory a, bool b, int c) internal {
        emit LogBytesBoolInt(a, b, c);
    }
    function log(bytes memory a, bool b, address c) internal {
        emit LogBytesBoolAddress(a, b, c);
    }
    function log(bytes memory a, bool b, bool c) internal {
        emit LogBytesBoolBool(a, b, c);
    }
    function log(bytes memory a, bool b, bytes32 c) internal {
        emit LogBytesBoolBytes32(a, b, c);
    }
    function log(bytes memory a, bool b, bytes memory c) internal {
        emit LogBytesBoolBytes(a, b, c);
    }
    function log(bytes memory a, bytes32 b, string memory c) internal {
        emit LogBytesBytes32String(a, b, c);
    }
    function log(bytes memory a, bytes32 b, uint c) internal {
        emit LogBytesBytes32Uint(a, b, c);
    }
    function log(bytes memory a, bytes32 b, int c) internal {
        emit LogBytesBytes32Int(a, b, c);
    }
    function log(bytes memory a, bytes32 b, address c) internal {
        emit LogBytesBytes32Address(a, b, c);
    }
    function log(bytes memory a, bytes32 b, bool c) internal {
        emit LogBytesBytes32Bool(a, b, c);
    }
    function log(bytes memory a, bytes32 b, bytes32 c) internal {
        emit LogBytesBytes32Bytes32(a, b, c);
    }
    function log(bytes memory a, bytes32 b, bytes memory c) internal {
        emit LogBytesBytes32Bytes(a, b, c);
    }
    function log(bytes memory a, bytes memory b, string memory c) internal {
        emit LogBytesBytesString(a, b, c);
    }
    function log(bytes memory a, bytes memory b, uint c) internal {
        emit LogBytesBytesUint(a, b, c);
    }
    function log(bytes memory a, bytes memory b, int c) internal {
        emit LogBytesBytesInt(a, b, c);
    }
    function log(bytes memory a, bytes memory b, address c) internal {
        emit LogBytesBytesAddress(a, b, c);
    }
    function log(bytes memory a, bytes memory b, bool c) internal {
        emit LogBytesBytesBool(a, b, c);
    }
    function log(bytes memory a, bytes memory b, bytes32 c) internal {
        emit LogBytesBytesBytes32(a, b, c);
    }
    function log(bytes memory a, bytes memory b, bytes memory c) internal {
        emit LogBytesBytesBytes(a, b, c);
    }
}