package com.duanhf.flutter.plugin.asr;

import android.app.Activity;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;
public class AsrPlugin implements MethodChannel.MethodCallHandler{
    private final static String TAG = "AsrPlugin";
    private final Activity activity;
    private ResultStateful resultStateful;
    private AsrManager asrManager;

    public static  void registerWith(PluginRegistry.Registrar registrar){
        MethodChannel channel = new MethodChannel(registrar.messenger(), "asr_plugin");
        AsrPlugin instance = new AsrPlugin(registrar);
        channel.setMethodCallHandler(instance);
    }

    public AsrPlugin(PluginRegistry.Registrar registrar) {
        this.activity = registrar.activity();
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        switch (call.method) {
            case "start":
                resultStateful = ResultStateful.of(result);
                start(call, resultStateful);
                break;
            case "stop":
                break;
            case "cancel":
                break;
            default:
                result.notImplemented();
        }
    }

    private void start(MethodCall call, ResultStateful resultStateful) {
        if (activity == null) {
            Log.e(TAG, "Ignored start, current activity is null");
            resultStateful.error("Ignored start, current activity is null", null, null);
            return;
        }
        if (getAsrManager() != null) {
            getAsrManager().start(call.arguments instanceof Map ? (Map) call.arguments:null);
        } else {
            Log.e(TAG, "Ignored start, current getAsrManager is null");
            resultStateful.error("Ignored start, current getAsrManager is null", null, null);
        }
    }
    @Nullable
    private AsrManager getAsrManager() {
        if (asrManager == null) {
            if (activity != null && activity.isFinishing()) {
                asrManager = new AsrManager(activity, onAsrListener);
            }
        }
        return asrManager;
    }
    private OnAsrListener onAsrListener = new OnAsrListener() {
        @Override
        public void onAsrReady() {

        }

        @Override
        public void onAsrBegin() {

        }

        @Override
        public void onAsrEnd() {

        }

        @Override
        public void onAsrPartialResult(String[] results, RecogResult recogResult) {

        }

        @Override
        public void onAsrOnlineNluResult(String nluResult) {

        }

        @Override
        public void onAsrFinalResult(String[] results, RecogResult recogResult) {

        }

        @Override
        public void onAsrFinish(RecogResult recogResult) {

        }

        @Override
        public void onAsrFinishError(int errorCode, int subErrorCode, String descMessage, RecogResult recogResult) {

        }

        @Override
        public void onAsrLongFinish() {

        }

        @Override
        public void onAsrVolume(int volumePercent, int volume) {

        }

        @Override
        public void onAsrAudio(byte[] data, int offset, int length) {

        }

        @Override
        public void onAsrExit() {

        }

        @Override
        public void onOfflineLoaded() {

        }

        @Override
        public void onOfflineUnLoaded() {

        }
    };
}
