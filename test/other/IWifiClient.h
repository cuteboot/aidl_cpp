/*
  Callback interface from Wifi
*/

#ifndef _IWIFI_CLIENT_H
#define _IWIFI_CLIENT_H

#include <binder/IInterface.h>
#include <utils/String8.h>

namespace android {

enum WifiState {
    WS_DISABLED,
    WS_DISABLING,
    WS_ENABLED,
    WS_ENABLING,
    WS_UNKNOWN
};

/* A station we have scanned */

class ScannedStation {
public:
    ScannedStation();
    ScannedStation(const ScannedStation&);
    ScannedStation(const Parcel& parcel);
    ScannedStation(const String8& inBssid, const String8& inSsid, 
		   const String8& inFlags, int inFrequency,
		   int inRssi);
    status_t writeToParcel(Parcel *parcel) const;

public:
    String8 bssid, ssid, flags;
    int     frequency, rssi;
};

/* 
 * A configured entry in wpa_supplicant.conf 
 * This is a simplified version of WifiConfiguration.java, where
 * we only allow open networks and networks with WPA-PSK.
 * 
 * Valid key_mgmt values:   NONE       Open network
 *                          WPA-PSK    WPA
 *
 * pre_shared_key is the WPA pre-shared key value.  When this is read
 * from the configuration file, it is set to "*" to indicate that a key exists.
 */

class ConfiguredStation {
public:
    enum Status { DISABLED, ENABLED, CURRENT };

    ConfiguredStation();
    ConfiguredStation(const ConfiguredStation&);
    ConfiguredStation(const Parcel& parcel);
    status_t writeToParcel(Parcel *parcel) const;

public:
    int     network_id, priority;
    String8 ssid, key_mgmt, pre_shared_key;
    Status  status;
};

/* Information about the current wifi connection */

class WifiInformation {
public:
    WifiInformation();
    WifiInformation(const WifiInformation&);
    WifiInformation(const Parcel& parcel);
    status_t writeToParcel(Parcel *parcel) const;

public:
    String8 macaddr, ipaddr, bssid, ssid;
    int     network_id, supplicant_state, rssi, link_speed;
};

// ------------------------------------------------------------

class IWifiClient : public IInterface
{
protected:
    enum {
	STATE = IBinder::FIRST_CALL_TRANSACTION,
	SCAN_RESULTS,
	CONFIGURED_STATIONS,
	INFORMATION,
	RSSI,
	LINK_SPEED
    };

public:
    DECLARE_META_INTERFACE(WifiClient);

    virtual void State(WifiState state) = 0;
    virtual void ScanResults(const Vector<ScannedStation>& scandata) = 0;
    virtual void ConfiguredStations(const Vector<ConfiguredStation>& configdata) = 0;
    virtual void Information(const WifiInformation& info) = 0;
    virtual void Rssi(int rssi) = 0;
    virtual void LinkSpeed(int link_speed) = 0;
};

// ----------------------------------------------------------------------------

class BnWifiClient : public BnInterface<IWifiClient>
{
public:
    virtual status_t onTransact(uint32_t code, 
				const Parcel& data,
				Parcel* reply, 
				uint32_t flags = 0);
};

};

#endif // _IWIFI_CLIENT_H

