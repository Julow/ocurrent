val init : ?level:Logs.level -> unit -> unit
(** Initialise the Logs library with some sensible defaults. *)

val with_dot :
  dotfile:Fpath.t ->
  (unit -> 'a Current.t) ->
  (unit -> 'a Current.t)
(** [with_dot ~dotfile pipeline] wraps [pipeline] to keep a dot diagram in
    [dotfile] showing its current state. *)

val run : unit Current.or_error Lwt.t -> unit Current.or_error
(** [run x] is like [Lwt_main.run x], but logs the returned error, if any. *)
