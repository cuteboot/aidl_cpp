package extra;

import extra.IMemory;

interface IAudioRecord {
    void start(int event, int triggerSession);
    void stop();
    IMemory getCblk();
}
