#!/usr/bin/env hhvm

use namespace Facebook\TypeAssert;
use namespace HH\Lib\Vec;

enum JsonTypes: string {
    posts = 'posts';
    comments = 'comments';
}

class API<T> {
    const ROUTE = 'https://jsonplaceholder.typicode.com/';
    const type posts = shape(
        "userId"=>int,
        "id"=>int,
        "title"=>string,
        "body"=>string
    );
    const type comments = shape(
        "postId"=>int,
        "id"=>int,
        "name"=>string,
        "email"=>string,
        "body"=>string
    );
    private string $url;
    public function __construct(
        private string $type
    ): void{
        $this->url = API::ROUTE."$type/";
    }
    public async function get_item(int $id): Awaitable<T> {
        $result = await \HH\Asio\curl_exec($this->url."/$id/");
        $error = null;
        $darray = json_decode_with_error($result, inout $error, true);
        /* HH_FIXME[4150] This just works */
        TypeAssert\matches_type_structure(type_structure(self::class, $this->type), $darray);
        return $darray;
    }
    public async function get_all(int $times): Awaitable<mixed> {
        $ids_to_fetch = vec[];
        for($i=1; $i<=$times; $i++) $ids_to_fetch[] = $this->get_item($i);
        return await Vec\from_async($ids_to_fetch);
    }
}

<<__EntryPoint>>
function main_fetcher():void{
    require_once(__DIR__.'/vendor/autoload.hack');
    \Facebook\AutoloadMap\initialize();
    $argvs = vec(\HH\global_get('argv') as Container<_>);
    $type = (string)($argvs[1] ?? "posts");
    $times = (int)($argvs[2] ?? 3);
    $fetcher = new API($type);
    $results = \HH\Asio\join($fetcher->get_all($times));
    var_dump($results);
}