package extra;

interface IAudioFlingerClient {
    void ioConfigChanged(int event, int ioHandle, in void[] param2);
}
