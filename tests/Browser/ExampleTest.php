<?php

namespace Tests\Browser;

use Illuminate\Foundation\Testing\DatabaseMigrations;
use Laravel\Dusk\Browser;
use Tests\DuskTestCase;

class ExampleTest extends DuskTestCase
{
  /**
     * Test to check if the home page displays "Stock Management".
     */
    public function testBasicExample()
    {
        $this->browse(function (Browser $browser) {
            $browser->visit('/') // Akses halaman utama
                    ->assertSee('Stock Management') // Periksa teks "Stock Management" pada halaman
                    ->assertSee('Product List') // Periksa teks "Product List"
                    ->assertPresent('a[href="http://127.0.0.1:8000/products/create"]') // Periksa link "Add New Product"
                    ->assertSeeIn('table thead tr', 'Name'); // Periksa apakah tabel memiliki kolom "Name"
        });
    }
}
