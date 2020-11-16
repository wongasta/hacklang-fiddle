namespace Hack\GettingStarted\FirstProgram;

<<__EntryPoint>>
function main(): void{
    echo "Welcome to Hack\n\n";
    \printf("Table of Squares\n".
           "------------------\n");
    for($i=-5; $i<=5; $i++){
    \printf("  %s       %s    \n", $i, $i*$i);
    }
    \printf("-----------------\n");
    exit(0);
}