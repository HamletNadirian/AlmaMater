package com.ntukhpi.otp.nadirian.lab03;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.util.Log;
import android.view.View;

import com.google.android.material.snackbar.Snackbar;

public class MainActivity extends AppCompatActivity {
        private final static String TAG = MainActivity.class.getName();

        protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Log.d(TAG, "onCreate");
    }
            @Override
            protected void onStart(){
            super.onStart();
            Log.d(TAG, "onStart");
    }

            @Override
            protected void onResume(){
            super.onResume();
            Log.d(TAG, "onResume");
    }
            @Override
            protected void onPause(){
             super.onPause();
             Log.d(TAG, "onPause");
            }
            @Override
            protected void onStop(){
            super.onStop();
            Log.d(TAG, "onStop");
    }
            @Override
            protected void onDestroy(){
            super.onDestroy();
            Log.d(TAG, "onDestroy");
    }
            @Override
            protected void onRestart(){
            super.onRestart();
            Log.d(TAG, "onRestart");
    }
    public void onClick(View view){
        Snackbar.make(view, "Надірян Г.О.", Snackbar.LENGTH_LONG)
                .show();
    }

}

