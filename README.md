# libgdiplus + Pango + Ellipsis Memory Corruption Example

To reproduce the memory corruption error do (you may have to do `docker run` more than once).

```sh
docker build -t local/pango-corruption -f Dockerfile .
docker run local/pango-corruption
```

To reproduce without docker on a machine (with libgdiplus using pango installed) just do `dotnet run`.

This produces a number of warnings/erros such as:

```
(process:93): GLib-WARNING **: 11:43:23.567: corrupted double-linked list detected
(process:93): GLib-CRITICAL **: 11:43:23.567: g_queue_push_head_link: assertion 'link->prev == NULL' failed
```
