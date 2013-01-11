package extra;
import import.SubSample;
import import.status_t;
import import.uint8_t;
import import.AString;
import import.CString;


interface ICrypto {
    status_t initCheck();
    boolean isCryptoSchemeSupported(in uint8_t[] uuid);
    status_t createPlugin( in uint8_t[] uuid, in void * data, long size);
    status_t destroyPlugin();
    boolean requiresSecureDecoderComponent( in CString mime);
    long decrypt( boolean secure, in uint8_t[] key, in uint8_t[] iv, int mode,
        in void * srcPtr, in SubSample * subSamples,
        long numSubSamples, out void * dstPtr, out AString * errorDetailMsg);
}
