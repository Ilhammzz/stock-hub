@extends('layout')

@section('content')
<h1 class="text-center">Stock Management</h1>
<h2 class="my-4">Product List</h2>
<a href="{{ route('products.create') }}" class="btn btn-primary mb-3">Add New Product</a>

@if(session('success'))
    <div class="alert alert-success">
        {{ session('success') }}
    </div>
@endif

<table class="table table-striped">
    <thead>
        <tr>
            <th>Name</th>
            <th>Quantity</th>
            <th>Price</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>
    @foreach($products as $product)
    <tr>
        <td>{{ $product->name }}</td>
        <td>{{ $product->quantity }}</td>
        <td>{{ $product->price }}</td>
        <td>
            <a href="{{ route('products.edit', $product) }}" class="btn btn-warning btn-sm">Edit</a>
            <form action="{{ route('products.destroy', $product) }}" method="POST" style="display:inline;">
                @csrf
                @method('DELETE')
                <button type="submit" class="btn btn-danger btn-sm">Delete</button>
            </form>
        </td>
    </tr>
    @endforeach
    </tbody>
</table>
@endsection
