package extra;

interface IPhoneClient {
    void Response(int token, int message, int result, int ivalue, in Parcel extra);
    void Unsolicited(int message, int ivalue, String svalue);
}
