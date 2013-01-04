/*
  Callback interface from Phone
*/

#ifndef _IPHONE_CLIENT_H
#define _IPHONE_CLIENT_H

#include <binder/IInterface.h>

namespace android {

enum UnsolicitedMessages {
    UM_NONE                        = 0x00,

    UM_RADIO_STATE_CHANGED         = 0x01,
    UM_CALL_STATE_CHANGED          = 0x02,
    UM_VOICE_NETWORK_STATE_CHANGED = 0x04,
    UM_NITZ_TIME_RECEIVED          = 0x08,
    UM_SIGNAL_STRENGTH             = 0x10,

    UM_ALL                         = 0xffff
};

/**
 * Interface back to a client window
 */

class IPhoneClient : public IInterface
{
public:

protected:
    enum {
	RESPONSE = IBinder::FIRST_CALL_TRANSACTION,
	UNSOLICITED,
    };

public:
    DECLARE_META_INTERFACE(PhoneClient);

    virtual void Response(int token, int message, int result, int ivalue, const Parcel& extra) = 0;
    virtual void Unsolicited(int message, int ivalue, const String16& svalue) = 0;
};

// ----------------------------------------------------------------------------

class BnPhoneClient : public BnInterface<IPhoneClient>
{
public:
    virtual status_t onTransact(uint32_t code, 
				const Parcel& data,
				Parcel* reply, 
				uint32_t flags = 0);
};

};

#endif // _IPHONE_CLIENT_H

