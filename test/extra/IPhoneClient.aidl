package extra;

import import.zParcel;

interface IPhoneClient {
    oneway void Response(int token, int message, int result,
        int ivalue, out zParcel extra);
    oneway void Unsolicited(int message, int ivalue, String svalue);
}
