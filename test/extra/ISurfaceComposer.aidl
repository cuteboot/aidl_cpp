package extra;
import import.ComposerState;
import extra.IDisplayEventConnection;
import extra.IGraphicBufferAlloc;
import extra.IMemoryHeap;
import extra.ISurfaceComposerClient;
import extra.ISurfaceTexture;
import import.PixelFormat;


interface ISurfaceComposer {
    ISurfaceComposerClient createConnection();
    IGraphicBufferAlloc createGraphicBufferAlloc();
    IMemoryHeap getCblk();
    void setTransactionState(in ComposerState * state,
        int orientation, int flags);
    void bootFinished();
    void captureScreen(int dpy, in IMemoryHeap * heap,
        in int *  width, in int *  height, in PixelFormat *  format,
        int reqWidth, int reqHeight, int minLayerZ, int maxLayerZ);
    void turnElectronBeamOff(int mode);
    void turnElectronBeamOn(int mode);
    boolean authenticateSurfaceTexture( ISurfaceTexture surface);
    IDisplayEventConnection createDisplayEventConnection();
}
