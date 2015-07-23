(* JsCoq
 * Copyright (C) 2015 Emilio Gallego / Mines ParisTech
 *
 * LICENSE: GPLv3+
 *)

(* Library manager for JsCoq

  Due to the large size of Coq libraries, we need to perform some
  caching and lazy loading in order to make the application usable.
*)

type coq_file =
  | VO  of string
  | CMA of string

(* Information about a Coq library. Note that we could access
   Loadpath.t too, but I've opted to keep this module separated from
   Coq *)
type coq_pkg = {
  name  : string list;
  files : (coq_file * Digest.t) list;
}

(* We likely want these to be Hashtbls of just js arrays. *)
type cache_entry = {
  (* url        : Js.js_string; *)
  content    : Js.js_string Js.t;
  md5        : Digest.t;
  }

type byte_cache_entry = {
  md5     : Digest.t; (* Or other signature *)
  js_code : Js.js_string;
}

(* Package list, should be autogenerated *)
val packages : coq_pkg list

val init : unit -> unit

val coq_resource_req : Js.js_string Js.t -> Js.js_string Js.t option

val preload_file : string -> (coq_file * int) -> unit Lwt.t
