--!strict
-- The 'test_luau_syntax.luau' file for Sublime Text 4 Luau highlighter testing.

local worker = zune.thread.fromModule("./worker")

worker:start()

for i = 1, 10 do
    worker:send(i)
end

for i = 1, 10 do
    local result = worker:receive()
    print(result)
end

worker:join()

local task = require("@lute/task")

local function loop()
    while true do
        task.defer()

        -- It may be useful to remove this print because it gets spammed, or implement another way
        -- in which you can determinatively tell whether or not the thread is still active despite
        -- an error in the other
        print("hi")
    end
end

local function otherloop()
    while true do
        task.defer()

        if math.random(1, 2) == 1 then
            error("oops")
        end
    end
end

coroutine.resume(coroutine.create(loop))
coroutine.resume(coroutine.create(otherloop))

--- Module-level constant for configuration.
local MAX_ATTEMPTS: number = 5

--- Type alias for a general point in 2D space.
export type Point = {
    x: number,
    y: number,
}

export type Formatter = (s: string, nocolor: boolean?) -> string

local function formatter(open: string, close: string, replace: string?): Formatter
    replace = replace or open

    return function(s, nocolor)
        return if nocolor then s else print(s, open, close, replace :: string)
    end
end

--- Type alias for a list of strings (an array).
type StringList = Array<string>

-- MARK: Basic Lua Syntax

local my_variable = 10         -- Number assignment
local is_active = true         -- Boolean assignment
local my_string = "Hello Luau" -- String with double quotes
local another_string = 'Single quote string' -- String with single quotes

-- Table (Dictionary/Map and Array)
local configuration: { [string]: any } = {
    -- Key-value pairs (dictionary)
    name = "TestConfig",
    version = 1.0,
    -- Array-like elements
    [1] = "First Item",
    [2] = "Second Item",
}

-- Conditional statement (if/elseif/else)
if my_variable > 5 and is_active then
    print("Condition is true!")
elseif my_variable == 10 then
    -- Luau table function example (Array.find)
    local item = table.find(configuration, "First Item")
    if item then
        print(`Found item at index: {item}`) -- String Interpolation example
    end
else
    -- Luau table function example (Array.clone)
    local cloned_config = table.clone(configuration)
    print("Configuration cloned.")
end

-- Loops (while and for)
local counter = 0
while counter < 3 do
    counter += 1 -- Compound assignment
end

for i = 1, 5, 2 do
    -- Loop body
    -- Another Luau function example (String.split)
    local parts: StringList = string.split(my_string, " ")
    print(parts[1])
end

-- Generic for loop for iterating over a dictionary
for key, value in pairs(configuration) do
    if typeof(value) == "number" then
        print(string.format("Key: %s, Value: %d", key, value))
    end
end

-- MARK: Luau Features and Types

--- Calculates the distance between two points.
-- @param p1 The first Point.
-- @param p2 The second Point.
-- @return The Euclidean distance as a number.
local function get_distance(p1: Point, p2: Point): number
    local dx: number = p2.x - p1.x
    local dy: number = p2.y - p1.y
    -- Luau math function example (math.pow)
    return math.sqrt(math.pow(dx, 2) + math.pow(dy, 2))
end

local function process_data(list: StringList): (number, string)
    -- Luau String Interpolation with expressions
    print(`Processing {list} which has {list and #list or 0} items.`)

    -- Luau extended string functions
    local joined_string = table.concat(list, ", ")
    return #joined_string, joined_string
end

-- Function calls and variable destructuring
local start_point: Point = { x = 0, y = 0 }
local end_point: Point = { x = 3, y = 4 }
local dist = get_distance(start_point, end_point)

-- Function call with destructuring
local length, result_string = process_data({"apple", "banana", "cherry"})

-- Type checking example (Optional: for testing the `typeof` keyword)
if typeof(dist) == "number" then
    print(`The distance is: {dist}`)
end

-- Optional type (nilable) usage
local optional_value: string? = nil
if optional_value then
    print("This won't print.")
else
    print("Optional value is nil.")
end

-- Use of Luau's built-in functions on a table
local numbers: { number } = { 10, 20, 30 }
local sum = table.reduce(numbers, 0, function(acc, n)
    return acc + n
end)
print(`The sum of numbers is: {sum}`)

-- Return at the end of the module (common pattern for Roblox modules)
return {
    get_distance = get_distance,
    process_data = process_data,
}

function assert<T>(value: T, message: string?): T
function error(obj: any, level: number?)
function gcinfo(): number
function getfenv(target: (function | number)?): table
function getmetatable(obj: any): table?
function next<K, V>(t: { [K]: V }, i: K?): (K, V)?
function newproxy(mt: boolean?): userdata
function print(args: ...any)
function rawequal(a: any, b: any): boolean
function rawget<K, V>(t: { [K]: V }, k: K): V?
function rawlen<K, V>(t: { [K]: V } | string): number
function rawset<K, V>(t: { [K] : V }, k: K, v: V)
function select<T>(i: string, args: ...T): number
function select<T>(i: number, args: ...T): ...T
function setfenv(target: function | number, env: table)
function setmetatable(t: table, mt: table?)
function tonumber(s: string, base: number?): number?
function tostring(obj: any): string
function type(obj: any): string
function typeof(obj: any): string
function ipairs(t: table): <iterator>
function pairs(t: table): <iterator>
function pcall(f: function, args: ...any): (boolean, ...any)
function xpcall(f: function, e: function, args: ...any): (boolean, ...any)
function unpack<V>(a: {V}, f: number?, t: number?): ...V
function math.abs(n: number): number
function math.acos(n: number): number
function math.asin(n: number): number
function math.atan2(y: number, x: number): number
function math.atan(n: number): number
function math.ceil(n: number): number
function math.cosh(n: number): number
function math.cos(n: number): number
function math.deg(n: number): number
function math.exp(n: number): number
function math.floor(n: number): number
function math.fmod(x: number, y: number): number
function math.frexp(n: number): (number, number)
function math.ldexp(s: number, e: number): number
function math.lerp(a: number, b: number, t: number): number
math.map(x: number, inmin: number, inmax: number, outmin: number, outmax: number): number
function math.log10(n: number): number
function math.log(n: number, base: number?): number
function math.max(list: ...number): number
function math.min(list: ...number): number
function math.modf(n: number): (number, number)
function math.pow(x: number, y: number): number
function math.rad(n: number): number
function math.random(): number
function math.random(n: number): number
function math.random(min: number, max: number): number
function math.randomseed(seed: number)
function math.sinh(n: number): number
function math.sin(n: number): number
function math.sqrt(n: number): number
function math.tanh(n: number): number
function math.tan(n: number): number
function math.noise(x: number, y: number?, z: number?): number
function math.clamp(n: number, min: number, max: number): number
function math.sign(n: number): number
function math.round(n: number): number
function table.concat(a: {string}, sep: string?, f: number?, t: number?): string
function table.foreach<K, V, R>(t: { [K]: V }, f: (K, V) -> R?): R?
function table.foreachi<V, R>(t: {V}, f: (number, V) -> R?): R?
function table.getn<V>(t: {V}): number
function table.maxn<V>(t: {V}): number
function table.insert<V>(t: {V}, v: V)
function table.insert<V>(t: {V}, i: number, v: V)
function table.remove<V>(t: {V}, i: number?): V?
function table.sort<V>(t: {V}, f: ((V, V) -> boolean)?)
function table.pack<V>(args: ...V): { [number]: V, n: number }
function table.unpack<V>(a: {V}, f: number?, t: number?): ...V
function table.move<V>(a: {V}, f: number, t: number, d: number, tt: {V}?)
function table.create<V>(n: number, v: V?): {V}
function table.find<V>(t: {V}, v: V, init: number?): number?
function table.clear(t: table)
function table.freeze(t: table): table
function table.isfrozen(t: table): boolean
function table.clone(t: table): table
function string.byte(s: string, f: number?, t: number?): ...number
function string.char(args: ...number): string
function string.find(s: string, p: string, init: number?, plain: boolean?): (number?, number?, ...string)
function string.format(s: string, args: ...any): string
function string.gmatch(s: string, p: string): <iterator>
function string.gsub(s: string, p: string, f: function | table | string, maxs: number?): (string, number)
function string.len(s: string): number
function string.lower(s: string): string
function string.match(s: string, p: string, init: number?): ...string?
function string.rep(s: string, n: number): string
function string.reverse(s: string): string
function string.sub(s: string, f: number, t: number?): string
function string.upper(s: string): string
function string.split(s: string, sep: string?): {string}
function string.pack(f: string, args: ...any): string
function string.packsize(f: string): number
function string.unpack(f: string, s: string): ...any
function coroutine.create(f: function): thread
function coroutine.running(): thread?
function coroutine.status(co: thread): string
function coroutine.wrap(f: function): function
function coroutine.yield(args: ...any): ...any
function coroutine.isyieldable(): boolean
function coroutine.resume(co: thread, args: ...any): (boolean, ...any)
function coroutine.close(co: thread): (boolean, any?)
function bit32.arshift(n: number, i: number): number
function bit32.band(args: ...number): number
function bit32.bnot(n: number): number
function bit32.bor(args: ...number): number
function bit32.bxor(args: ...number): number
function bit32.btest(args: ...number): boolean
function bit32.extract(n: number, f: number, w: number?): number
function bit32.lrotate(n: number, i: number): number
function bit32.lshift(n: number, i: number): number
function bit32.replace(n: number, r: number, f: number, w: number?): number
function bit32.rrotate(n: number, i: number): number
function bit32.rshift(n: number, i: number): number
function bit32.countlz(n: number): number
function bit32.countrz(n: number): number
function bit32.byteswap(n: number): number
function utf8.offset(s: string, n: number, i: number?): number?
function utf8.codepoint(s: string, i: number?, j: number?): ...number
function utf8.char(args: ...number): string
function utf8.len(s: string, i: number?, j: number?): number?
function utf8.codes(s: string): <iterator>
function os.clock(): number
function os.date(s: string?, t: number?): table | string
function os.difftime(a: number, b: number): number
function os.time(t: table?): number
function debug.info(co: thread, level: number, s: string): ...any
function debug.info(level: number, s: string): ...any
function debug.info(f: function, s: string): ...any
function debug.traceback(co: thread, msg: string?, level: number?): string
function debug.traceback(msg: string?, level: number?): string
function buffer.create(size: number): buffer
function buffer.fromstring(str: string): buffer
function buffer.tostring(b: buffer): string
function buffer.len(b: buffer): number
function buffer.readi8(b: buffer, offset: number): number
function buffer.readu8(b: buffer, offset: number): number
function buffer.readi16(b: buffer, offset: number): number
function buffer.readu16(b: buffer, offset: number): number
function buffer.readi32(b: buffer, offset: number): number
function buffer.readu32(b: buffer, offset: number): number
function buffer.readf32(b: buffer, offset: number): number
function buffer.readf64(b: buffer, offset: number): number
function buffer.writei8(b: buffer, offset: number, value: number): ()
function buffer.writeu8(b: buffer, offset: number, value: number): ()
function buffer.writei16(b: buffer, offset: number, value: number): ()
function buffer.writeu16(b: buffer, offset: number, value: number): ()
function buffer.writei32(b: buffer, offset: number, value: number): ()
function buffer.writeu32(b: buffer, offset: number, value: number): ()
function buffer.writef32(b: buffer, offset: number, value: number): ()
function buffer.writef64(b: buffer, offset: number, value: number): ()
function buffer.readstring(b: buffer, offset: number, count: number): string
function buffer.writestring(b: buffer, offset: number, value: string, count: number?): ()
buffer.readbits(b: buffer, bitOffset: number, bitCount: number): number
buffer.writebits(b: buffer, bitOffset: number, bitCount: number, value: number): ()
function buffer.copy(target: buffer, targetOffset: number, source: buffer, sourceOffset: number?, count: number?): ()
function buffer.fill(b: buffer, offset: number, value: number, count: number?): ()
vector.zero
vector.one
vector.create(x: number, y: number, z: number): vector
vector.create(x: number, y: number, z: number, w: number): vector
vector.magnitude(vec: vector): number
vector.normalize(vec: vector): vector
vector.cross(vec1: vector, vec2: vector): vector
vector.dot(vec1: vector, vec2: vector): number
vector.angle(vec1: vector, vec2: vector, axis: vector?): number
vector.floor(vec: vector): vector
vector.ceil(vec: vector): vector
vector.abs(vec: vector): vector
vector.sign(vec: vector): vector
vector.clamp(vec: vector, min: vector, max: vector): vector
vector.max(...: vector): vector
vector.min(...: vector): vector
