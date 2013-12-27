module("resty.leveldb", package.seeall)

local ffi = require "ffi"

--  $ gcc -P -E quicklz.h
-- after deleting some relevent code
ffi.cdef[[
 typedef __builtin_va_list __gnuc_va_list;
typedef __gnuc_va_list va_list;
typedef long int ptrdiff_t;
typedef long unsigned int size_t;
typedef int wchar_t;
typedef signed char int8_t;
typedef short int int16_t;
typedef int int32_t;
typedef long int int64_t;
typedef unsigned char uint8_t;
typedef unsigned short int uint16_t;
typedef unsigned int uint32_t;
typedef unsigned long int uint64_t;
typedef signed char int_least8_t;
typedef short int int_least16_t;
typedef int int_least32_t;
typedef long int int_least64_t;
typedef unsigned char uint_least8_t;
typedef unsigned short int uint_least16_t;
typedef unsigned int uint_least32_t;
typedef unsigned long int uint_least64_t;
typedef signed char int_fast8_t;
typedef long int int_fast16_t;
typedef long int int_fast32_t;
typedef long int int_fast64_t;
typedef unsigned char uint_fast8_t;
typedef unsigned long int uint_fast16_t;
typedef unsigned long int uint_fast32_t;
typedef unsigned long int uint_fast64_t;
typedef long int intptr_t;
typedef unsigned long int uintptr_t;
typedef long int intmax_t;
typedef unsigned long int uintmax_t;
typedef struct leveldb_t leveldb_t;
typedef struct leveldb_cache_t leveldb_cache_t;
typedef struct leveldb_comparator_t leveldb_comparator_t;
typedef struct leveldb_env_t leveldb_env_t;
typedef struct leveldb_filelock_t leveldb_filelock_t;
typedef struct leveldb_filterpolicy_t leveldb_filterpolicy_t;
typedef struct leveldb_iterator_t leveldb_iterator_t;
typedef struct leveldb_logger_t leveldb_logger_t;
typedef struct leveldb_options_t leveldb_options_t;
typedef struct leveldb_randomfile_t leveldb_randomfile_t;
typedef struct leveldb_readoptions_t leveldb_readoptions_t;
typedef struct leveldb_seqfile_t leveldb_seqfile_t;
typedef struct leveldb_snapshot_t leveldb_snapshot_t;
typedef struct leveldb_writablefile_t leveldb_writablefile_t;
typedef struct leveldb_writebatch_t leveldb_writebatch_t;
typedef struct leveldb_writeoptions_t leveldb_writeoptions_t;
 leveldb_t* leveldb_open(
    const leveldb_options_t* options,
    const char* name,
    char** errptr);
 void leveldb_close(leveldb_t* db);
 void leveldb_put(
    leveldb_t* db,
    const leveldb_writeoptions_t* options,
    const char* key, size_t keylen,
    const char* val, size_t vallen,
    char** errptr);
 void leveldb_delete(
    leveldb_t* db,
    const leveldb_writeoptions_t* options,
    const char* key, size_t keylen,
    char** errptr);
 void leveldb_write(
    leveldb_t* db,
    const leveldb_writeoptions_t* options,
    leveldb_writebatch_t* batch,
    char** errptr);
 char* leveldb_get(
    leveldb_t* db,
    const leveldb_readoptions_t* options,
    const char* key, size_t keylen,
    size_t* vallen,
    char** errptr);
 leveldb_iterator_t* leveldb_create_iterator(
    leveldb_t* db,
    const leveldb_readoptions_t* options);
 const leveldb_snapshot_t* leveldb_create_snapshot(
    leveldb_t* db);
 void leveldb_release_snapshot(
    leveldb_t* db,
    const leveldb_snapshot_t* snapshot);
 char* leveldb_property_value(
    leveldb_t* db,
    const char* propname);
 void leveldb_approximate_sizes(
    leveldb_t* db,
    int num_ranges,
    const char* const* range_start_key, const size_t* range_start_key_len,
    const char* const* range_limit_key, const size_t* range_limit_key_len,
    uint64_t* sizes);
 void leveldb_compact_range(
    leveldb_t* db,
    const char* start_key, size_t start_key_len,
    const char* limit_key, size_t limit_key_len);
 void leveldb_destroy_db(
    const leveldb_options_t* options,
    const char* name,
    char** errptr);
 void leveldb_repair_db(
    const leveldb_options_t* options,
    const char* name,
    char** errptr);
 void leveldb_iter_destroy(leveldb_iterator_t*);
 unsigned char leveldb_iter_valid(const leveldb_iterator_t*);
 void leveldb_iter_seek_to_first(leveldb_iterator_t*);
 void leveldb_iter_seek_to_last(leveldb_iterator_t*);
 void leveldb_iter_seek(leveldb_iterator_t*, const char* k, size_t klen);
 void leveldb_iter_next(leveldb_iterator_t*);
 void leveldb_iter_prev(leveldb_iterator_t*);
 const char* leveldb_iter_key(const leveldb_iterator_t*, size_t* klen);
 const char* leveldb_iter_value(const leveldb_iterator_t*, size_t* vlen);
 void leveldb_iter_get_error(const leveldb_iterator_t*, char** errptr);
 leveldb_writebatch_t* leveldb_writebatch_create();
 void leveldb_writebatch_destroy(leveldb_writebatch_t*);
 void leveldb_writebatch_clear(leveldb_writebatch_t*);
 void leveldb_writebatch_put(
    leveldb_writebatch_t*,
    const char* key, size_t klen,
    const char* val, size_t vlen);
 void leveldb_writebatch_delete(
    leveldb_writebatch_t*,
    const char* key, size_t klen);
 void leveldb_writebatch_iterate(
    leveldb_writebatch_t*,
    void* state,
    void (*put)(void*, const char* k, size_t klen, const char* v, size_t vlen),
    void (*deleted)(void*, const char* k, size_t klen));
 leveldb_options_t* leveldb_options_create();
 void leveldb_options_destroy(leveldb_options_t*);
 void leveldb_options_set_comparator(
    leveldb_options_t*,
    leveldb_comparator_t*);
 void leveldb_options_set_filter_policy(
    leveldb_options_t*,
    leveldb_filterpolicy_t*);
 void leveldb_options_set_create_if_missing(
    leveldb_options_t*, unsigned char);
 void leveldb_options_set_error_if_exists(
    leveldb_options_t*, unsigned char);
 void leveldb_options_set_paranoid_checks(
    leveldb_options_t*, unsigned char);
 void leveldb_options_set_env(leveldb_options_t*, leveldb_env_t*);
 void leveldb_options_set_info_log(leveldb_options_t*, leveldb_logger_t*);
 void leveldb_options_set_write_buffer_size(leveldb_options_t*, size_t);
 void leveldb_options_set_max_open_files(leveldb_options_t*, int);
 void leveldb_options_set_cache(leveldb_options_t*, leveldb_cache_t*);
 void leveldb_options_set_block_size(leveldb_options_t*, size_t);
 void leveldb_options_set_block_restart_interval(leveldb_options_t*, int);
enum {
  leveldb_no_compression = 0,
  leveldb_snappy_compression = 1
};
 void leveldb_options_set_compression(leveldb_options_t*, int);
 leveldb_comparator_t* leveldb_comparator_create(
    void* state,
    void (*destructor)(void*),
    int (*compare)(
        void*,
        const char* a, size_t alen,
        const char* b, size_t blen),
    const char* (*name)(void*));
 void leveldb_comparator_destroy(leveldb_comparator_t*);
 leveldb_filterpolicy_t* leveldb_filterpolicy_create(
    void* state,
    void (*destructor)(void*),
    char* (*create_filter)(
        void*,
        const char* const* key_array, const size_t* key_length_array,
        int num_keys,
        size_t* filter_length),
    unsigned char (*key_may_match)(
        void*,
        const char* key, size_t length,
        const char* filter, size_t filter_length),
    const char* (*name)(void*));
 void leveldb_filterpolicy_destroy(leveldb_filterpolicy_t*);
 leveldb_filterpolicy_t* leveldb_filterpolicy_create_bloom(
    int bits_per_key);
 leveldb_readoptions_t* leveldb_readoptions_create();
 void leveldb_readoptions_destroy(leveldb_readoptions_t*);
 void leveldb_readoptions_set_verify_checksums(
    leveldb_readoptions_t*,
    unsigned char);
 void leveldb_readoptions_set_fill_cache(
    leveldb_readoptions_t*, unsigned char);
 void leveldb_readoptions_set_snapshot(
    leveldb_readoptions_t*,
    const leveldb_snapshot_t*);
 leveldb_writeoptions_t* leveldb_writeoptions_create();
 void leveldb_writeoptions_destroy(leveldb_writeoptions_t*);
 void leveldb_writeoptions_set_sync(
    leveldb_writeoptions_t*, unsigned char);
 leveldb_cache_t* leveldb_cache_create_lru(size_t capacity);
 void leveldb_cache_destroy(leveldb_cache_t* cache);
 leveldb_env_t* leveldb_create_default_env();
 void leveldb_env_destroy(leveldb_env_t*);
 void leveldb_free(void* ptr);
 int leveldb_major_version();
 int leveldb_minor_version();
]]

local leveldb = ffi.load("/opt/source/leveldb-1.15.0/libleveldb.so",true)
if not leveldb then
  error("load leveldb failed!")
  return
end

local function create_options(options)
  options = options or {}
  local c_options = leveldb.leveldb_options_create()
  if options.create_if_missing then leveldb.leveldb_options_set_create_if_missing(c_options, 1) end
  if options.error_if_exists   then leveldb.leveldb_options_set_error_if_exists(c_options, 1)   end
  if options.compression       then leveldb.leveldb_options_set_compression(c_options, 1)       end
  return c_options
end

local function create_read_options(options)
  options = options or {}
  local c_options = leveldb.leveldb_readoptions_create()
  return c_options
end

local function create_write_options(options)
  options = options or {}
  local c_options = leveldb.leveldb_writeoptions_create()
  return c_options
end

DB = {}
print('test')
function DB:new(filename, options)
  obj = {}
  setmetatable(obj, self)

  self.__index = self
  self.__gc = function()
    if self._db then
      leveldb.leveldb_free(self._db)
    end
  end
  
  local c_options = create_options(options)
  local c_err = ffi.new("char*[1]")
  if self._db ==nil then
    self._db = leveldb.leveldb_open(c_options, filename, c_err)
  end
  leveldb.leveldb_options_destroy(c_options)
  if c_err[0] ~= nil then
    --error(ffi.string(c_err[0]))
  end

  local major = leveldb.leveldb_major_version()
  local minor = leveldb.leveldb_minor_version()
  self.version = major .. "." .. minor

  return obj
end

function DB:close()
  leveldb.leveldb_close(self._db)
end

function DB:get(key, options)
  local c_options = create_read_options(options)
  local c_err = ffi.new("char*[1]")
  local c_size = ffi.new("size_t[1]")
  local c_result = leveldb.leveldb_get(self._db, c_options, key, #key, c_size, c_err)
  leveldb.leveldb_readoptions_destroy(c_options)
  if c_err[0] ~= nil then
    error(ffi.string(c_err[0]))
  elseif c_size[0] == 0 then
    return nil
  else
    return ffi.string(c_result, c_size[0])
  end
end

function DB:put(key, val, options)
  local c_options = create_write_options(options)
  local c_err = ffi.new("char*[1]")
  leveldb.leveldb_put(self._db, c_options, key, #key, val, #val, c_err)
  leveldb.leveldb_writeoptions_destroy(c_options)
  if c_err[0] ~= nil then
    error(ffi.string(c_err[0]))
  end
end

function DB:delete(key, options)
  local c_options = create_write_options(options)
  local c_err = ffi.new("char*[1]")
  leveldb.leveldb_delete(self._db, c_options, key, #key, c_err)
  leveldb.leveldb_writeoptions_destroy(c_options)
  if c_err[0] ~= nil then
    error(ffi.string(c_err[0]))
  end
end

function DB:batch(options)
  return WriteBatch:new(self._db, options)
end

function DB:iterator(options)
  return Iterator:new(self._db, options)
end

WriteBatch = {}

function WriteBatch:new(db, options)
  obj = {}
  setmetatable(obj, self)

  self.__index = self
  self.__gc = function()
    if self._batch then
      leveldb.leveldb_free(self._batch)
    end
    if self._options then
      leveldb.leveldb_writeoptions_destroy(self._options)
    end
  end

  self._db = db
  self._options = create_write_options(options)
  self._batch = leveldb.leveldb_writebatch_create()

  return obj
end

function WriteBatch:put(key, val)
  leveldb.leveldb_writebatch_put(self._batch, key, #key, val, #val)
end

function WriteBatch:delete(key)
  leveldb.leveldb_writebatch_delete(self._batch, key, #key)
end

function WriteBatch:write()
  local c_err = ffi.new("char*[1]")
  leveldb.leveldb_write(self._db, self._options, self._batch, c_err)
  if c_err[0] ~= nil then
    error(ffi.string(c_err[0]))
  end
end

Iterator = {}

function Iterator:new(db, options)
  obj = {}
  setmetatable(obj, self)

  self.__index = self
  self.__gc = function()
    if self._iterator then
      leveldb.leveldb_iter_destroy(self._iterator)
    end
    if self._options then
      leveldb.leveldb_readoptions_destroy(self._options)
    end
  end

  self._db = db
  self._options = create_read_options(options)
  self._iterator = leveldb.leveldb_create_iterator(self._db, self._options)

  return obj
end

function Iterator:first()
  leveldb.leveldb_iter_seek_to_first(self._iterator)
end

function Iterator:last()
  leveldb.leveldb_iter_seek_to_last(self._iterator)
end

function Iterator:seek(key)
  leveldb.leveldb_iter_seek(self._iterator, key, #key)
end

function Iterator:next()
  leveldb.leveldb_iter_next(self._iterator)
  
  local valid = leveldb.leveldb_iter_valid(self._iterator)
  if valid == 0 then
    return nil
  end

  local c_key_size = ffi.new("size_t[1]")
  local c_key = leveldb.leveldb_iter_key(self._iterator, c_key_size)
  local key = ffi.string(c_key, c_key_size[0])

  local c_value_size = ffi.new("size_t[1]")
  local c_value = leveldb.leveldb_iter_value(self._iterator, c_value_size)
  local value = ffi.string(c_value, c_value_size[0])

  return key, value
end

M = {}

M.open = function(filename, options)
  return DB:new(filename, options)
end

M.close = function()
  return DB:close()
end

M.destroy = function(filename, options)
  local c_options = create_options(options)
  local c_err = ffi.new("char*[1]")

  leveldb.leveldb_destroy_db(c_options, filename, c_err)
  leveldb.leveldb_options_destroy(c_options)

  if c_err[0] ~= nil then
    error(ffi.string(c_err[0]))
  end
end

M.repair = function(filename, options)
  local c_options = create_options(options)
  local c_err = ffi.new("char*[1]")

  leveldb.leveldb_repair_db(c_options, filename, c_err)
  leveldb.leveldb_options_destroy(c_options)

  if c_err[0] ~= nil then
    error(ffi.string(c_err[0]))
  end
end

local testdb = nil

M.reloaddb = function()
  local b=nil
  print(b==nil) 
  if testdb == nil then

         print("testdb is nil")
         
         testdb = DB:new("/opt/source/testdb",{error_if_exists=false});
  else
        print("testdb is not nil")
  end

  return testdb
  
end

return M
