<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{{ $title ?? config('app.name') }}</title>
    @vite(['resources/css/app.css', 'resources/js/app.js'])
</head>
<body class="bg-gray-50 text-gray-900 antialiased">
    <nav class="bg-white border-b border-gray-200">
        <div class="max-w-5xl mx-auto px-4 py-3 flex items-center justify-between">
            <a href="/" class="font-semibold text-lg">URL Shortener</a>
            <a href="/dashboard" class="text-sm text-gray-600 hover:text-gray-900">Dashboard</a>
        </div>
    </nav>
    <main class="max-w-5xl mx-auto px-4 py-8">
        {{ $slot }}
    </main>
</body>
</html>
