<?php

namespace App\Http\Controllers;

use App\Pregunta;
use App\Seccion_Encuesta;
use App\Mensaje;
use App\Respuesta;
use Illuminate\Http\Request;

class Seccion_EncuestaController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index($encuesta_id)
    {
        //GET
     /*   $users = DB::table('users')
            ->orderBy('name', 'desc')
            ->get();
    */
     $seccion = Seccion_Encuesta::get();
       echo json_encode($seccion);

    }
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
   /* public function showSecciones($encuesta_id) {
        try {
            $encuesta_id;
           // $encuesta = Encuesta::where('PK_ENCUESTA', $encuesta_id)->first();
            $secciones = Seccion_Encuesta::where('FK_ENCUESTA', $encuesta_id)

                //$seccion = Seccion_Encuesta::where('FK_ENCUESTA', $encuesta_id)
                ->where('BORRADO', '0' )
                ->get();

        }catch (\Exception $exception){
            return response($exception);
            \Monolog\Handler\error_log($exception);
            error_log($exception);
        }
    }*/

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //POST
        //$seccion_e->FECHA_REGISTRO = date('Y-m-d H:i:s');
        try {
            $seccion_e = new Seccion_Encuesta();
            $seccion_e->FK_ENCUESTA = $request->input('FK_ENCUESTA');
            $seccion_e->NOMBRE_SECCION = $request->input('NOMBRE_SECCION');
            $seccion_e->NUMERO_SECCION = $request->input('NUMERO_SECCION');
            $seccion_e->OBJETIVO = $request->input('OBJETIVO');
            $seccion_e->INSTRUCCIONES = $request->input('INSTRUCCIONES');
            $seccion_e->save();
            return response()->json((array) new Respuesta('OK', 200, Mensaje::CREADO, $seccion_e));
        }catch (\Exception $exception){
            return response()->json((array) new Respuesta('ERROR', 400, Mensaje::BD_ERR, $seccion_e));
            echo json_encode($exception);
        }
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $encuesta_id
     * @return \Illuminate\Http\Response
     */
    public function show($encuesta_id)
    {
        //get
      //  $seccion_e = Seccion_Encuesta::find($seccion_id);
        // echo json_encode($seccion_e);

        try {
            $secciones = Seccion_Encuesta::where('FK_ENCUESTA', $encuesta_id)
                ->where('BORRADO', '0' )
                ->get();
        }catch (\Exception $exception){
            return response($exception);
            error_log($exception);
        }

    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $seccion_id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $seccion_id)
    {
        //PUT
        try {
            $seccion_e = Seccion_Encuesta::find($seccion_id);
            $seccion_e->NUMERO_SECCION = $request->input('NUMERO_SECCION');
            $seccion_e->NOMBRE_SECCION = $request->input('NOMBRE_SECCION');
            $seccion_e->OBJETIVO = $request->input('OBJETIVO');
            $seccion_e->INSTRUCCIONES = $request->input('INSTRUCCIONES');
            $seccion_e->save();
            return response()->json((array) new Respuesta('OK', 200, Mensaje::ACTUALIZADO, $seccion_e));
        }catch (\Exception $exception){
            return response()->json((array) new Respuesta('ERROR', 400, Mensaje::BD_ERR, $seccion_e));
        }
    }


    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $seccion_id
     * @return \Illuminate\Http\Response
     */
    public function destroy($seccion_id)
    {
        try{
        $seccion_id;
        $seccion = Seccion_Encuesta::where('PK_SECCION', $seccion_id)->first();
        $preguntas = Pregunta::where('FK_SECCION', $seccion_id)->get();
        if(count($preguntas) >=1){
            $seccion;
            $seccion->BORRADO = '1';
            $seccion->save();
            return response()->json((array) new Respuesta('OK', 200, Mensaje::BORRADO, $seccion));
        }else {
            // echo "\$encuesta esta vacio y no tiene secciones";
            $seccion->first();
            $preguntas;
            $seccion->delete();
            return response()->json((array) new Respuesta('OK', 200, Mensaje::BORRADO, $seccion));
        }
    }catch (\Exception $exception) {
        // echo ($exception);
        return response()->json((array) new Respuesta('ERROR', 400, Mensaje::BD_ERR, $seccion));
    }



        /*
        //DELETE
        try{
            $seccion_e = Seccion_Encuesta::find($seccion_id);
            $seccion_e->delete();
            return response()->json((array) new Respuesta('OK', 200, Mensaje::BORRADO, $seccion_e));
        }catch (\Exception $exception){
            return response()->json((array) new Respuesta('ERROR', 400, Mensaje::BD_ERR, $seccion_e));
        }*/
    }
}
