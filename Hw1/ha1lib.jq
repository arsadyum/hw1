jsoniq version "3.0";
module namespace mm = "ha1lib.jq";
import module namespace file = "http://expath.org/ns/file";
import module namespace math = "http://www.w3.org/2005/xpath-functions/math";
import module namespace r= "http://zorba.io/modules/random";
declare namespace ann = "http://zorba.io/annotations";
import module namespace sctx = "http://zorba.io/modules/sctx";
import module namespace fetch = "http://zorba.io/modules/fetch";
(: import module namespace dgal = "http://dgms.io/modules/analytics";

import module namespace coll = "http://repository.vsnet.gmu.edu/config/collection.jq";
:)

declare function mm:ha1($univDB) {
(:
let $univDB := jn:parse-json(fetch:content("sampleUnivDB.json"))
let $univDB := $jn:parse-json(fetch:content($file))
:)
let $department := $univDB.tables.department[],
    $course := $univDB.tables.course[],
    $prereq := $univDB.tables.prereq[],
    $class := $univDB.tables.class[],
    $faculty := $univDB.tables.faculty[],
    $student := $univDB.tables.student[],
    $enrollment := $univDB.tables.enrollment[],
    $transcript := $univDB.tables.transcript[]
(: boolean queries - each must return true or false :)
let $boolQuery_a := some $s in $student, $t in $transcript
					satisfies ($t.ssn = 82 and
							   $t.dcode = "CS" and
							   $t.cno = 530)

let $boolQuery_b := some $s in $student, $t in $transcript
					satisfies ($s.name = "John Smith" and
								$t.ssn = $s.ssn and
							   $t.dcode = "CS" and
							   $t.cno = 530)
(:) All students named “John  Smith” has taken the course “CS 530”
(must be in Transcipts)
:)
let $boolQuery_c := some $s in $student, $t in $transcript
					satisfies ($s.name = "John Smith" and
								$t.ssn = $s.ssn and
							   $t.dcode = "CS" and
							   $t.cno = 530)

(:The student with ssn = 82  has satisfied all prerequisites for each
class she is enrolled in.
:)
(:let $boolQuery_d := some $s in $student, $e in $enrollment, $t in $transcript
        satisfies (every $cl in $class, $p in $prereq
          satisfies $t.cno = $prereq.class and
                $t.dcode = $p.dcode and
                $cl.cno = $p.cno and
                $e.ssn = 82)
:)
let $boolQuery_d :=  some $e in $enrollment, $s in $student
    satisfies (every $cl in $class,
                    $p in $prereq
                satisfies if ($e.class = $cl.class and
                        $cl.cno = $p.cno)
                        then some $t in $transcript
                          satisfies ($t.ssn = 82 and
                        $t.dcode = $p.pcode and
                          $t.cno = $p.pno
                        ) else true
                        )



let $boolQuery_e :=every $e in $enrollment
satisfies (every $cl in $class,
                            $p in $prereq
                satisfies if($e.class = $cl.class and
                                   $cl.cno = $p.cno)
                               then some $t in $transcript
                                        satisfies ($t.ssn = $e.ssn and
                                                        $t.dcode = $p.pcode and
                                                        $t.cno = $p.pno)
                                                        else true)


let $boolQuery_f := "tbd"

let $boolQuery_g := "tbd"

let $boolQuery_h := "tbd"

let $boolQuery_i := "tbd"

let $boolQuery_j := "tbd"

let $boolQuery_k := "tbd"

let $boolQuery_l := "tbd"

(: now data queries; before each one there's a description of output structure :)

(: returns an array of objects
[  { ssn: ..., name: ..., major: ..., status: ... }, ... ]
:)
let $dataQuery_a := [
let $ssn_cs530 := (
                   for $t in $transcript
                   where $t.dcode = "CS" and $t.cno = 530
         return $t.ssn
         )

         for $s in $student, $n in $ssn_cs530
         where $s.ssn = $n
         return {
           ssn: $s.ssn,
                     name: $s.name,
                     major: $s.major,
                     status: $s.status
         }
]
(: returns an array of objects
[  { ssn: ..., name: ..., major: ..., status: ... }, ... ]
:)
let $dataQuery_b := [
  "tbd"
]
(: returns an array of objects
[  { ssn: ..., name: ..., major: ..., status: ... }, ... ]
:)
let $dataQuery_c := [
  "tbd"
]
(: returns an array of objects
[  { ssn: ..., name: ..., major: ..., status: ... }, ... ]
:)
let $dataQuery_d := [
  "tbd"
]
(: returns an array of objects
[  { ssn: ..., name: ..., major: ..., status: ... }, ... ]
:)
let $dataQuery_e := [
  "tbd"
]
(: returns an array of objects
[   {dcode: …, cno: …} , ... ]
:)
let $dataQuery_f := [
  "tbd"
]
(: returns an array of objects
[   {dcode: …, cno: …} , ... ]
:)
let $dataQuery_g := [
  "tbd"
]
(: returns an array of objects
[    {class: ..., dcode: ..., cno: ..., instr: ...}  , ... ]
:)
let $dataQuery_h := [
  "tbd"
]
(: returns an array of objects
[  { ssn: ..., name: ..., major: ..., status: ... }, ... ]
:)
let $dataQuery_i := [
  "tbd"
]
(: returns an array of objects
[  { ssn: ..., name: ..., major: ..., status: ... }, ... ]
:)
let $dataQuery_j := [
  "tbd"
]

return {
  boolQuery_a: $boolQuery_a,
  boolQuery_b: $boolQuery_b,
  boolQuery_c: $boolQuery_c,
  boolQuery_d: $boolQuery_d,
  boolQuery_e: $boolQuery_e,
  boolQuery_f: $boolQuery_f,
  boolQuery_g: $boolQuery_g,
  boolQuery_h: $boolQuery_h,
  boolQuery_i: $boolQuery_i,
  boolQuery_j: $boolQuery_j,
  boolQuery_k: $boolQuery_k,
  boolQuery_l: $boolQuery_l,
  dataQuery_a: $dataQuery_a,
  dataQuery_b: $dataQuery_b,
  dataQuery_c: $dataQuery_c,
  dataQuery_d: $dataQuery_d,
  dataQuery_e: $dataQuery_e,
  dataQuery_f: $dataQuery_f,
  dataQuery_g: $dataQuery_g,
  dataQuery_h: $dataQuery_h,
  dataQuery_i: $dataQuery_i,
  dataQuery_j: $dataQuery_j
}
};
