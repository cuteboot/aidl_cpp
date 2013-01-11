package extra;
import extra.IPhoneClient;


interface IPhoneService {
    oneway void Register(IPhoneClient client, int flags);
    oneway void Request(IPhoneClient client, int token, int message,
        int ivalue, String svalue);
}
