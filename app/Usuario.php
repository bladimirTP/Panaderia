<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Support\Facades\Hash;

class Usuario extends Model
{
    use SoftDeletes;
    protected $table = "usuario";
    public $timestamps = true;
    protected $fillable = ['idusuario', 'email', 'password', 'fkidcliente', 'fkidpersonal', 'token', 'roles', 'permissions', 'name'];
    protected $primaryKey = 'idusuario';

    protected $dates = [
        'updated_at',
        'created_at',
        'deleted_at',
    ];

    public function personal()
    {
        return $this->belongsTo(Personal::class, 'fkidpersonal');
    }

    public function user()
    {
        return $this->hasOne(User::class, 'fkidusuario', 'idusuario');
    }

    public function setPasswordAttribute($input)
    {
        if ($input) {
            $this->attributes['password'] = app('hash')->needsRehash($input) ? Hash::make($input) : $input;
        }
    }

    public function cliente()
    {
        return $this->belongsTo(Cliente::class, 'fkidcliente');
    }
}
