package com.ntukhpi.otp.nadirian.lab05;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.CheckBox;
import android.widget.ImageView;
import android.widget.TextView;

import java.util.ArrayList;
import java.util.List;
import java.util.zip.Inflater;

public class BoxAdapter extends BaseAdapter {
    Context ctx;
    LayoutInflater lInflater;
    ArrayList<Product> objects;
    BoxAdapter(Context context,ArrayList<Product> products){
        ctx=context;
        objects=products;
        lInflater=(LayoutInflater)ctx.getSystemService(Context.LAYOUT_INFLATER_SERVICE);

    }

    public ArrayList<Product> getList(){
        return objects;
    }

    @Override
    public int getCount() {
        return objects.size();
    }

    @Override
    public Object getItem(int position) {
        return objects.get(position);
    }

    @Override
    public long getItemId(int position) {
        return position;
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        View view = convertView;
        if(view==null){
            view=lInflater.inflate(R.layout.item,parent,false);
        }

        Product p = getProduct(position);

        ((TextView) view.findViewById(R.id.random)).setText(p.name);
        ((TextView) view.findViewById(R.id.decrypt)).setText(p.surname + "");
        ((ImageView) view.findViewById(R.id.ivImage)).setImageResource(p.image);
        return view;
    }

    Product getProduct(int position) {
        return ((Product) getItem(position));
    }
    ArrayList<Product> getBox() {
        ArrayList<Product> box = new ArrayList<Product>();
        for (Product p : objects) {
            if (p.box)
                box.add(p);
        }
        return box;
    }
    public View getView_(int position, View convertView, ViewGroup parent) {
        View view = convertView;
        if(view==null){
            view=lInflater.inflate(R.layout.item,parent,false);
        }

        Product p = getProduct(position);


        ((TextView) view.findViewById(R.id.random)).setText(p.name);
        ((TextView) view.findViewById(R.id.decrypt)).setText(p.surname + "");
        ((ImageView) view.findViewById(R.id.ivImage)).setImageResource(p.image);
        return view;
    }

    public void setData(ArrayList<Product> list) {
        objects.clear();
        objects.addAll(list);
        this.notifyDataSetChanged();
    }


}
