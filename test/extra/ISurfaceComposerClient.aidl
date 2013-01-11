package extra;
import extra.ISurface;

import import.surface_data_t;
import import.String8;
import import.status_t;

interface ISurfaceComposerClient {
    ISurface createSurface( in surface_data_t *  data, in String8 name,
        int display, int w, int h, int format, int flags);
    status_t destroySurface(int sid);
}
