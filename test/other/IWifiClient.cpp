/*
 */

#include <binder/Parcel.h>
#include <wifi/IWifiClient.h>

namespace android {

ScannedStation::ScannedStation()
    : frequency(-1), rssi(-9999)
{
}

ScannedStation::ScannedStation(const ScannedStation& other)
    : bssid(other.bssid)
    , ssid(other.ssid)
    , flags(other.flags)
    , frequency(other.frequency)
    , rssi(other.rssi)
{
}

ScannedStation::ScannedStation(const Parcel& parcel)
{
    bssid = parcel.readString8();
    ssid  = parcel.readString8();
    flags = parcel.readString8();
    frequency = parcel.readInt32();
    rssi      = parcel.readInt32();
}

ScannedStation::ScannedStation(const String8& inBssid, const String8& inSsid, 
			       const String8& inFlags, int inFrequency,
			       int inRssi) 
    : bssid(inBssid)
    , ssid(inSsid)
    , flags(inFlags)
    , frequency(inFrequency)
    , rssi(inRssi)
{
}

status_t ScannedStation::writeToParcel(Parcel *parcel) const
{
    parcel->writeString8(bssid);
    parcel->writeString8(ssid);
    parcel->writeString8(flags);
    parcel->writeInt32(frequency);
    parcel->writeInt32(rssi);
    return NO_ERROR;
}

// ------------------------------------------------------------

ConfiguredStation::ConfiguredStation()
    : network_id(-1)
    , priority(0)
    , status(ENABLED)
{
}

ConfiguredStation::ConfiguredStation(const ConfiguredStation& other)
    : network_id(other.network_id)
    , priority(other.priority)
    , ssid(other.ssid)
    , key_mgmt(other.key_mgmt)
    , pre_shared_key(other.pre_shared_key)
    , status(other.status)
{
}

ConfiguredStation::ConfiguredStation(const Parcel& parcel)
{
    network_id     = parcel.readInt32();
    priority       = parcel.readInt32();
    ssid           = parcel.readString8();
    key_mgmt       = parcel.readString8();
    pre_shared_key = parcel.readString8();
    status         = static_cast<Status>(parcel.readInt32());
}

status_t ConfiguredStation::writeToParcel(Parcel *parcel) const
{
    parcel->writeInt32(network_id);
    parcel->writeInt32(priority);
    parcel->writeString8(ssid);
    parcel->writeString8(key_mgmt);
    parcel->writeString8(pre_shared_key);
    parcel->writeInt32(status);
    return NO_ERROR;
}

// ------------------------------------------------------------

WifiInformation::WifiInformation()
    : network_id(-1)
    , supplicant_state(0)
    , rssi(-9999)
    , link_speed(-1)
{
}

WifiInformation::WifiInformation(const WifiInformation& other)
    : macaddr(other.macaddr)
    , ipaddr(other.ipaddr)
    , bssid(other.bssid)
    , ssid(other.ssid)
    , network_id(other.network_id)
    , supplicant_state(other.supplicant_state)
    , rssi(other.rssi)
    , link_speed(other.link_speed)
{
}

WifiInformation::WifiInformation(const Parcel& parcel)
{
    macaddr          = parcel.readString8();
    ipaddr           = parcel.readString8();
    bssid            = parcel.readString8();
    ssid             = parcel.readString8();
    network_id       = parcel.readInt32();
    supplicant_state = parcel.readInt32();
    rssi             = parcel.readInt32();
    link_speed       = parcel.readInt32();
}

status_t WifiInformation::writeToParcel(Parcel *parcel) const
{
    parcel->writeString8(macaddr);
    parcel->writeString8(ipaddr);
    parcel->writeString8(bssid);
    parcel->writeString8(ssid);
    parcel->writeInt32(network_id);
    parcel->writeInt32(supplicant_state);
    parcel->writeInt32(rssi);
    parcel->writeInt32(link_speed);
    return NO_ERROR;
}

// ------------------------------------------------------------

class BpWifiClient : public BpInterface<IWifiClient>
{
public:
    BpWifiClient(const sp<IBinder>& impl)
	: BpInterface<IWifiClient>(impl)
    {
    }

    void State(WifiState state) {
	Parcel data, reply;
	data.writeInterfaceToken(IWifiClient::getInterfaceDescriptor());
	data.writeInt32(state);
	remote()->transact(STATE, data, &reply, IBinder::FLAG_ONEWAY);
    }

    void ScanResults(const Vector<ScannedStation>& scandata) {
	Parcel data, reply;
	data.writeInterfaceToken(IWifiClient::getInterfaceDescriptor());
	data.writeInt32(scandata.size());
	for (size_t i=0 ; i < scandata.size() ; i++)
	    scandata[i].writeToParcel(&data);
	remote()->transact(SCAN_RESULTS, data, &reply, IBinder::FLAG_ONEWAY);
    }

    void ConfiguredStations(const Vector<ConfiguredStation>& configdata) {
	Parcel data, reply;
	data.writeInterfaceToken(IWifiClient::getInterfaceDescriptor());
	data.writeInt32(configdata.size());
	for (size_t i = 0 ; i < configdata.size() ; i++)
	    configdata[i].writeToParcel(&data);
	remote()->transact(CONFIGURED_STATIONS, data, &reply, IBinder::FLAG_ONEWAY);
    }

    void Information(const WifiInformation& info) {
	Parcel data, reply;
	data.writeInterfaceToken(IWifiClient::getInterfaceDescriptor());
	info.writeToParcel(&data);
	remote()->transact(INFORMATION, data, &reply, IBinder::FLAG_ONEWAY);
    }

    void Rssi(int rssi) {
	Parcel data, reply;
	data.writeInterfaceToken(IWifiClient::getInterfaceDescriptor());
	data.writeInt32(rssi);
	remote()->transact(RSSI, data, &reply, IBinder::FLAG_ONEWAY);
    }

    void LinkSpeed(int link_speed) {
	Parcel data, reply;
	data.writeInterfaceToken(IWifiClient::getInterfaceDescriptor());
	data.writeInt32(link_speed);
	remote()->transact(LINK_SPEED, data, &reply, IBinder::FLAG_ONEWAY);
    }
};

// ---------------------------------------------------------------------------

status_t BnWifiClient::onTransact( uint32_t code, 
				    const Parcel& data, 
				    Parcel* reply, 
				    uint32_t flags )
{
    switch(code) {
    case STATE: {
	CHECK_INTERFACE(IWifiClient, data, reply);
	WifiState state = static_cast<WifiState>(data.readInt32());
	State(state);
	return NO_ERROR;
    } break;
    case SCAN_RESULTS: {
	CHECK_INTERFACE(IWifiClient, data, reply);
	Vector<ScannedStation> v;
	int vlen = data.readInt32();
	for (int i = 0 ; i < vlen ; i++) 
	    v.push(ScannedStation(data));
	ScanResults(v);
	return NO_ERROR;
    } break;
    case CONFIGURED_STATIONS: {
	CHECK_INTERFACE(IWifiClient, data, reply);
	Vector<ConfiguredStation> v;
	int vlen = data.readInt32();
	for (int i = 0 ; i < vlen ; i++) 
	    v.push(ConfiguredStation(data));
	ConfiguredStations(v);
	return NO_ERROR;
    } break;
    case INFORMATION: {
	CHECK_INTERFACE(IWifiClient, data, reply);
	WifiInformation info(data);
	Information(info);
	return NO_ERROR;
    } break;
    case RSSI: {
	CHECK_INTERFACE(IWifiClient, data, reply);
	int rssi = data.readInt32();
	Rssi(rssi);
	return NO_ERROR;
    } break;
    case LINK_SPEED: {
	CHECK_INTERFACE(IWifiClient, data, reply);
	int link_speed = data.readInt32();
	LinkSpeed(link_speed);
	return NO_ERROR;
    } break;
    }
    return BBinder::onTransact(code, data, reply, flags);
}

IMPLEMENT_META_INTERFACE(WifiClient, "WifiClient")

// ----------------------------------------------------------------------------
}; // namespace Android
