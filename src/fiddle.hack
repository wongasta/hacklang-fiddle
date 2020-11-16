use namespace HH\Lib\Vec;

<<__EntryPoint>>
function main():void{
    require_once(__DIR__.'/../vendor/autoload.hack');
    \Facebook\AutoloadMap\initialize();
    $x=vec[1,2,3]
        |> Vec\map($$, $a ==> $a*$a)
        |> Vec\sort($$);
    var_dump($x);
    exit(0);
}