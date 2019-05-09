#!/bin/bash

# get all dir. absolute paht is perfect
echo "dir is :" $1
prex='.java'

function findFile(){
local path=$1

for file in $path/*
do
    if [ -d $file ] ;then
        echo $file
        findFile $file
    elif [ -f $file ]; then  
        local len=${#file} 
        local sublen=${#prex} 
        if [ $prex == ${file:len-sublen:len} ] ; then
            sedFile $file
        fi
    fi
    done

}

function sedFile() {
    local file=$1
    echo $file;
    sed 's/com.clw.vehicle.remote.EventedVehicleMessage/com.imotor.framework.vehicle.remote.EventedVehicleMessage/g' $file > $file.bak
    mv $file.bak $file
    sed 's/com.clw.vehicle.remote.IndexedVehicleMessage/com.imotor.framework.vehicle.remote.IndexedVehicleMessage/g' $file > $file.bak
    mv $file.bak $file
    sed 's/com.clw.vehicle.remote.KeyParamCommand/com.imotor.framework.vehicle.remote.KeyParamCommand/g' $file > $file.bak
    mv $file.bak $file
    sed 's/com.clw.vehicle.remote.ParamCommand/com.imotor.framework.vehicle.remote.ParamCommand/g' $file > $file.bak
    mv $file.bak $file
    sed 's/com.clw.vehicle.remote.SimpleCommand/com.imotor.framework.vehicle.remote.SimpleCommand/g' $file > $file.bak
    mv $file.bak $file
    sed 's/com.clw.vehicle.remote.SimpleVehicleMessage/com.imotor.framework.vehicle.remote.SimpleVehicleMessage/g' $file > $file.bak
    mv $file.bak $file
    sed 's/com.clw.vehicle.remote.VehicleMessage/com.imotor.framework.vehicle.remote.VehicleMessage/g' $file > $file.bak
    mv $file.bak $file
    sed 's/com.clw.vehicle.util.Objects/com.imotor.framework.vehicle.util.Objects/g' $file > $file.bak
    mv $file.bak $file
    sed 's/com.clw.vehicle.util.Nullable/com.imotor.framework.vehicle.util.Nullable/g' $file > $file.bak
    mv $file.bak $file
    sed 's/com.clw.vehicle.util.Preconditions/com.imotor.framework.vehicle.util.Preconditions/g' $file > $file.bak
    mv $file.bak $file
    sed 's/com.clw.vehicle.util.DataPipeline/com.imotor.framework.vehicle.util.DataPipeline/g' $file > $file.bak
    mv $file.bak $file
    sed 's/com.clw.vehicle.util.Range/com.imotor.framework.vehicle.util.Range/g' $file > $file.bak
    mv $file.bak $file
    sed 's/com.clw.vehicle.util.AgingData/com.imotor.framework.vehicle.util.AgingData/g' $file > $file.bak
    mv $file.bak $file

    sed 's/com.clw.vehicle.units.Unit/com.imotor.framework.vehicle.units.Unit/g' $file > $file.bak
    mv $file.bak $file
    sed 's/com.clw.vehicle.units.Int/com.imotor.framework.vehicle.units.Int/g' $file > $file.bak
    mv $file.bak $file
    sed 's/com.clw.vehicle.units.State/com.imotor.framework.vehicle.units.State/g' $file > $file.bak
    mv $file.bak $file
    sed 's/com.clw.vehicle.units.Quantity/com.imotor.framework.vehicle.units.Quantity/g' $file > $file.bak
    mv $file.bak $file

    sed 's/com.clw.vehicle.remote.VehicleServiceListener/com.imotor.framework.vehicle.remote.VehicleServiceListener/g' $file > $file.bak
    mv $file.bak $file

    sed 's/com.clw.vehicle.sinks.AbstractQueuedCallbackSink/com.imotor.framework.vehicle.sinks.AbstractQueuedCallbackSink/g' $file > $file.bak
    mv $file.bak $file
    sed 's/com.clw.vehicle.sinks.AndroidKeyEventSink/com.imotor.framework.vehicle.sinks.AndroidKeyEventSink/g' $file > $file.bak
    mv $file.bak $file
    sed 's/com.clw.vehicle.sinks.BaseVehicleDataSink/com.imotor.framework.vehicle.sinks.BaseVehicleDataSink/g' $file > $file.bak
    mv $file.bak $file
    sed 's/com.clw.vehicle.sinks.ContextualVehicleDataSink/com.imotor.framework.vehicle.sinks.ContextualVehicleDataSink/g' $file > $file.bak
    mv $file.bak $file
    sed 's/com.clw.vehicle.sinks.DataSinkException/com.imotor.framework.vehicle.sinks.DataSinkException/g' $file > $file.bak
    mv $file.bak $file
    sed 's/com.clw.vehicle.sinks.RemoteCallbackSink/com.imotor.framework.vehicle.sinks.RemoteCallbackSink/g' $file > $file.bak
    mv $file.bak $file
    sed 's/com.clw.vehicle.sinks.VehicleDataListenerSink/com.imotor.framework.vehicle.sinks.VehicleDataListenerSink/g' $file > $file.bak
    mv $file.bak $file
    sed 's/com.clw.vehicle.sinks.VehicleDataSink/com.imotor.framework.vehicle.sinks.VehicleDataSink/g' $file > $file.bak
    mv $file.bak $file

    sed 's/com.clw.vehicle.properties.Property/com.imotor.framework.vehicle.properties.Property/g' $file > $file.bak
    mv $file.bak $file
    sed 's/com.clw.vehicle.properties.PropertyProducer/com.imotor.framework.vehicle.properties.PropertyProducer/g' $file > $file.bak
    mv $file.bak $file
    sed 's/com.clw.vehicle.properties.UnrecognizedPropertyTypeException/com.imotor.framework.vehicle.properties.UnrecognizedPropertyTypeException/g' $file > $file.bak
    mv $file.bak $file
    sed 's/com.clw.vehicle.properties.AndroidKeyEvent/com.imotor.framework.vehicle.properties.AndroidKeyEvent/g' $file > $file.bak
    mv $file.bak $file

    sed 's/com.clw.vehicle.properties.EventedProperty/com.imotor.framework.vehicle.properties.EventedProperty/g' $file > $file.bak
    mv $file.bak $file

    sed 's/com.clw.vehicle.NoValueException/com.imotor.framework.vehicle.NoValueException/g' $file > $file.bak
    mv $file.bak $file

    sed 's/com.clw.vehicle.sources.SourceCallback/com.imotor.framework.sources.SourceCallback/g' $file > $file.bak
    mv $file.bak $file
    sed 's/com.clw.vehicle.sources.VehicleDataSource/com.imotor.framework.sources.VehicleDataSource/g' $file > $file.bak
    mv $file.bak $file
    sed 's/com.clw.vehicle.sources.RemoteListenerSource/com.imotor.framework.sources.RemoteListenerSource/g' $file > $file.bak
    mv $file.bak $file
    sed 's/com.clw.vehicle.sources.BaseVehicleDataSource/com.imotor.framework.sources.BaseVehicleDataSource/g' $file > $file.bak
    mv $file.bak $file
}

function getCurrent(){
	/bin/pwd
}

if [ $# -eq 0 ] ; then
	findFile $(getCurrent) 
elif [ -n $1 ] ; then
	if [ $1 == "." -o $1 == "./" ] ; then
		findFile $(getCurrent)
	else
		path=$1
		findFile ${path%/}
		unset path
	fi
else
	echo "path is null!"
fi
