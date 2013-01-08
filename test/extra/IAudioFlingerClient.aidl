package extra;

interface IAudioFlingerClient {
    // param2 is either "uint32_t" or "AudioSystem::OutputDescriptor",
    // depending on event!
    void ioConfigChanged(int event, int ioHandle, in int * param2);
}
