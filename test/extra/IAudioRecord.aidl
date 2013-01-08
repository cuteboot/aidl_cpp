package extra;

import extra.IMemory;
import import.status_t;

interface IAudioRecord {
    IMemory getCblk();
    status_t start(int event, int triggerSession);
    void stop();
}
