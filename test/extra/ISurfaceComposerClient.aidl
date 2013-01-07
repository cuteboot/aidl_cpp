package extra;
import extra.ISurface;


interface ISurfaceComposerClient {
    ISurface createSurface( surface_data_t[]  data, String name, int display, int w, int h, PixelFormat format, int flags);
    void destroySurface(int sid);
}
