package extra;
import import.omx_message;


interface IOMXObserver {
    void bogus_connect(); /* only in IOMX interface */
    void bogus_livesLocally(); /* only in IOMX interface */
    void bogus_listNodes(); /* only in IOMX interface */
    void bogus_allocateNode(); /* only in IOMX interface */
    void bogus_freeNode(); /* only in IOMX interface */
    void bogus_sendCommand(); /* only in IOMX interface */
    void bogus_getParameter(); /* only in IOMX interface */
    void bogus_setParameter(); /* only in IOMX interface */
    void bogus_getConfig(); /* only in IOMX interface */
    void bogus_setConfig(); /* only in IOMX interface */
    void bogus_getState(); /* only in IOMX interface */
    void bogus_enableGraphicBuffers(); /* only in IOMX interface */
    void bogus_useBuffer(); /* only in IOMX interface */
    void bogus_useGraphicBuffer(); /* only in IOMX interface */
    void bogus_storeMetaDataInBuffers(); /* only in IOMX interface */
    void bogus_allocateBuffer(); /* only in IOMX interface */
    void bogus_allocateBufferWithBackup(); /* only in IOMX interface */
    void bogus_freeBuffer(); /* only in IOMX interface */
    void bogus_fillBuffer(); /* only in IOMX interface */
    void bogus_emptyBuffer(); /* only in IOMX interface */
    void bogus_getExtensionIndex(); /* only in IOMX interface */

    void onMessage(in omx_message msg);

    void bogus_getGraphicBufferUsage(); /* only in IOMX interface */
}
