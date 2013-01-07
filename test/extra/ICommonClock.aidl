package extra;
import extra.ICommonClockListener;
import extra.sockaddr_storage;
import extra.State;



interface ICommonClock {
    void isCommonTimeValid(in boolean[]  valid, in int[]  timelineID);
    void commonTimeToLocalTime(long commonTime, in long[]  localTime);
    void localTimeToCommonTime(long localTime, in long[]  commonTime);
    void getCommonTime(out long[]  commonTime);
    void getCommonFreq(out long[]  freq);
    void getLocalTime(out long[]  localTime);
    void getLocalFreq(out long[]  freq);
    void getEstimatedError(out int[]  estimate);
    void getTimelineID(out long[]  id);
    void getState(out State[]  state);
    void getMasterAddr(out sockaddr_storage[]  addr);
    void registerListener( in ICommonClockListener listener);
    void unregisterListener( in ICommonClockListener listener);
}
