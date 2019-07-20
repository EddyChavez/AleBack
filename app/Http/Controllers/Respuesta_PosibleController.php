<?php

namespace App\Http\Controllers;

use App\Respuesta_Posible;
use Illuminate\Http\Request;

class Respuesta_PosibleController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //GET
        $respuesta = Respuesta_Posible::get();
        echo json_encode($respuesta);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //POST
        try {
            $respuesta = new Respuesta_Posible();
            $respuesta->FK_PREGUNTA = $request->input('FK_PREGUNTA');
            $respuesta->RESPUESTA = $request->input('RESPUESTA');
            $respuesta->save();
            return response()->json((array) new Respuesta('OK', 200, Mensaje::CREADO, $respuesta));
        }catch (\Exception $exception){
            return response()->json((array) new Respuesta('ERROR', 400, $exception, $respuesta));
        }
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $respuesta_id
     * @return \Illuminate\Http\Response
     */
    public function show($respuesta_id)
    {
        //GET
        $respuesta = Respuesta_Posible::find($respuesta_id);
        echo json_encode($respuesta);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $respuesta_id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $respuesta_id)
    {
        //PUT
        try {
            $respuesta = Respuesta_Posible::find($respuesta_id);
            $respuesta->RESPUESTA = $request->input('RESPUESTA');
            $respuesta->save();
            return response()->json((array) new Respuesta('OK', 200, Mensaje::ACTUALIZADO, $respuesta));
        }catch (\Exception $exception){
            return response()->json((array) new Respuesta('ERROR', 400, Mensaje::BD_ERR, $respuesta));
        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $respuesta_id
     * @return \Illuminate\Http\Response
     */
    public function destroy($respuesta_id)
    {
        //DELETE
        try{
            $respuesta = Respuesta_Posible::find($respuesta_id);
            $respuesta->delete();
            return response()->json((array) new Respuesta('OK', 200, Mensaje::BORRADO, $respuesta));
        }catch (\Exception $exception){
            return response()->json((array) new Respuesta('ERROR', 400, Mensaje::BD_ERR, $respuesta));
        }
    }
}
