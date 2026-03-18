<?php

namespace App\Http\Controllers;

use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\DB;

class HealthCheckController extends Controller
{
    public function __invoke(): JsonResponse
    {
        $dbOk = rescue(fn () => DB::select('SELECT 1') && true, false);

        return response()->json([
            'data' => [
                'status' => $dbOk ? 'ok' : 'degraded',
                'timestamp' => now()->toIso8601String(),
            ],
        ]);
    }
}
