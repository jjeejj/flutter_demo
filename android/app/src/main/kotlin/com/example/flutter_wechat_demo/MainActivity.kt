package com.example.flutter_wechat_demo

import io.flutter.embedding.android.FlutterActivity
import android.os.Build
import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        val getAndroidBuildModelMethodChannel = MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger, 
            "iyi.com/getAndroidBuildModel"
        )
        
        getAndroidBuildModelMethodChannel.setMethodCallHandler { call: MethodCall, result: MethodChannel.Result ->
            if (call.method == "getBuildModel") {
                val buildModel = getBuildModel()
                if (buildModel != null && buildModel.isNotBlank()) {
                    result.success(buildModel)
                } else {
                    result.error("err", "无法获取 Build Model 信息", "Build.MODEL 值为 null 或空字符串")
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun getBuildModel(): String? {
        return Build.MODEL
    }
}
