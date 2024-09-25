<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class AuthController extends Controller
{
    public function login(Request $request)
    {
        return response()->json(['message' => 'Login bem-sucedido!']); 
    }

    public function cadastro(Request $request)
    {
        return response()->json(['message' => 'Login bem-sucedido!']); 
    }
}
