package extra;
import extra.ISurface;

import import.surface_data_t;

interface ISurfaceComposerClient {
    ISurface createSurface( in surface_data_t *  data, String name,
        int display, int w, int h, int format, int flags);
    void destroySurface(int sid);
}
