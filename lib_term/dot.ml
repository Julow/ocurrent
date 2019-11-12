let list_bind f x =
  List.map f x |> List.concat

let pp_option f (name, v) =
  Fmt.pf f "%s=%S" name v

let node f ?style ?shape ?bg ?url ?tooltip i label =
  let attrs = [
    "label", Some label;
    "fillcolor", bg;
    "style", style;
    "shape", shape;
    "URL", url;
    "tooltip", tooltip;
    "target", (if url = None then None else Some "_top");
  ] |> list_bind (function
      | _, None -> []
      | k, Some v -> [k, v]
    )
  in
  Fmt.pf f "n%d [%a]@," i Fmt.(list ~sep:(unit ",") pp_option) attrs

let pp_options f = function
  | [] -> ()
  | items ->
    Fmt.pf f " [%a]"
      (Fmt.list ~sep:(Fmt.unit ",") pp_option) items

let edge f ?style ?color a b =
  let styles = [
    "style", style;
    "color", color;
  ] |> list_bind (function
      | _, None -> []
      | k, Some v -> [k, v]
    )
  in
  Fmt.pf f "n%d -> n%d%a@," a b pp_options styles

let begin_cluster f i =
  Fmt.pf f "subgraph cluster_%d {@," i

let end_cluster f =
  Fmt.pf f "}@,"
