<?php

test('health check returns ok status', function () {
    $response = $this->getJson('/api/health');

    $response->assertOk()
        ->assertJsonPath('data.status', 'ok')
        ->assertJsonStructure([
            'data' => ['status', 'timestamp'],
        ]);
});
