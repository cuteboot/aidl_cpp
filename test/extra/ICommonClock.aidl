package extra;
import extra.ICommonClockListener;
import import.sockaddr_storage;
import import.State;
import import.status_t;



interface ICommonClock {
    status_t isCommonTimeValid(out boolean * valid, out int * timelineID);
    status_t commonTimeToLocalTime(long commonTime, out long * localTime);
    status_t localTimeToCommonTime(long localTime, out long * commonTime);
    status_t getCommonTime(out long *  commonTime);
    status_t getCommonFreq(out long *  freq);
    status_t getLocalTime(out long *  localTime);
    status_t getLocalFreq(out long *  freq);
    status_t getEstimatedError(out int *  estimate);
    status_t getTimelineID(out long *  id);
    status_t getState(out State *  state);
    status_t getMasterAddr(out sockaddr_storage *  addr);
    status_t registerListener( in ICommonClockListener listener);
    status_t unregisterListener( in ICommonClockListener listener);
}
