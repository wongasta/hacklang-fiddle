use namespace HH\Lib\Vec;

function square_vec(vec<num> $numbers): vec<num> {
    return Vec\map($numbers, $number==>{
        return $number*$number;
    });
}
