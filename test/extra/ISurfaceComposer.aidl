package extra;
import import.ComposerState;
import extra.IDisplayEventConnection;
import extra.IGraphicBufferAlloc;
import extra.IMemoryHeap;
import extra.ISurfaceComposerClient;
import extra.ISurfaceTexture;
import import.PixelFormat;
import import.status_t;


interface ISurfaceComposer {
    void bootFinished();
    ISurfaceComposerClient createConnection();
    IGraphicBufferAlloc createGraphicBufferAlloc();
    IMemoryHeap getCblk();
    void setTransactionState(in ComposerState * state,
        int orientation, int flags);
    void setOrientation(); /* not defined */
    status_t captureScreen(int dpy, in IMemoryHeap * heap,
        in int *  width, in int *  height, in PixelFormat *  format,
        int reqWidth, int reqHeight, int minLayerZ, int maxLayerZ);
    status_t turnElectronBeamOff(int mode);
    status_t turnElectronBeamOn(int mode);
    boolean authenticateSurfaceTexture( ISurfaceTexture surface);
    IDisplayEventConnection createDisplayEventConnection();
}
