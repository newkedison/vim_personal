" Last Change: 2011-11-25 17:00:53
" Vim syntax file
" Language:	C++ special highlighting for STL classes and methods
" Maintainer:	Jean-Francois Guchens (thanks to Nathan Skvirsky)
" Last Change:	2008 May 02

syn keyword cppSTL   abort abs accumulate acos adjacent_difference adjacent_find adjacent_find_if any append asctime asin assert assign at atan atan2 atexit atof atoi atol 
syn keyword cppSTL   back back_inserter bad bad_alloc bad_cast bad_exception bad_typeid badbit beg begin binary_compose binary_negate binary_search bind2nd binder1st binder2nd bitset bsearch 
syn keyword cppSTL   c_str calloc capacity ceil cerr cin clear clearerr clock clog close compare compose1 compose2 construct copy copy_backward copy_n cos cosh count count_if cout ctime 
syn keyword cppSTL   data destroy difference_type difftime div domain_error 
syn keyword cppSTL   empty end endl eof eofbit equal equal_range erase exception exit exp 
syn keyword cppSTL   fabs fail failbit failure fclose feof ferror fflush fgetc fgetpos fgets fill fill_n find find_end find_first_not_of find_first_of find_if find_last_not_of find_last_of first flags flip floor flush fmod fopen for_each fprintf fputc fputs fread free freopen frexp front fscanf fseek fsetpos ftell fwrite 
syn keyword cppSTL   gcount generate generate_n get get_temporary_buffer getc getchar getenv getline gets gmtime good goodbit greater greater_equal 
syn keyword cppSTL   ignore in includes inner_product inplace_merge insert inserter invalid_argument ios ios_base iostate iota is_heap is_open is_sorted isalnum isalpha iscntrl isdigit isgraph islower isprint ispunct isspace isupper isxdigit iter_swap iterator_category 
syn keyword cppSTL   key_comp 
syn keyword cppSTL   ldiv length length_error less less_equal lexicographical_compare lexicographical_compare_3way localtime log log10 logic_error logical_and logical_not logical_or longjmp lower_bound 
syn keyword cppSTL   make_heap malloc max max_element max_size mem_fun mem_fun1 mem_fun1_ref mem_fun_ref memchr memcpy memmove memset merge min min_element minus mismatch mktime modf modulus multiplies 
syn keyword cppSTL   negate next_permutation npos nth_element numeric_limits 
syn keyword cppSTL   open  out_of_range overflow_error 
syn keyword cppSTL   partial_sort partial_sort_copy partial_sum partition peek perror plus pop pop_back pop_front pop_heap pow power precision prev_permutation printf ptr_fun push push_back push_front push_heap put putback putc putchar puts 
syn keyword cppSTL   qsort 
syn keyword cppSTL   raise rand random_sample random_sample_n random_shuffle range_error rbegin rdbuf rdstate read realloc reference remove remove_copy remove_copy_if remove_if rename rend replace replace_copy replace_copy_if replace_if reserve reset resize return_temporary_buffer reverse reverse_copy rewind rfind rotate rotate_copy runtime_error 
syn keyword cppSTL   scanf search search_n second seekg seekp set_difference set_intersection set_symmetric_difference set_union setbuf setf setjmp setlocale setvbuf signal sin sinh size size_t size_type sort sort_heap splice sprintf sqrt srand sscanf stable_partition stable_sort std str strcat strchr strcmp strcoll strcpy strcspn strerror strftime string strlen strncat strncmp strncpy strpbrk strrchr strspn strstr strtod strtok strtol strtoul strxfrm substr swap swap_ranges sync_with_stdio system 
syn keyword cppSTL   tan tanh tellg tellp test time time_t tmpfile tmpnam to_string to_ulong tolower top toupper transform 
syn keyword cppSTL   unary_compose unary_negate underflow_error unget ungetc uninitialized_copy uninitialized_copy_n uninitialized_fill uninitialized_fill_n unique unique_copy unsetf upper_bound 
syn keyword cppSTL   va_arg value_comp value_type vfprintf vprintf vsprintf 
syn keyword cppSTL   width write

syn keyword cppSTL   lock unlock defer_lock usleep chrono sleep wait wait_for wait_until notify_one notify_all

"/////////////////////////////////////////////////
syn keyword cppSTLtype   auto_ptr
syn keyword cppSTLtype   back_insert_iterator basic_string bidirectional_iterator bidirectional_iterator_tag binary_compose binary_function binary_negate binder1st binder2nd bit_vector bitset
syn keyword cppSTLtype   char_producer char_traits const_iterator
syn keyword cppSTLtype   deque divides equal_to
syn keyword cppSTLtype   filebuf forward_iterator forward_iterator_tag front_insert_iterator fstream
syn keyword cppSTLtype   hash hash_map hash_multimap hash_multiset hash_set
syn keyword cppSTLtype   ifstream input_iterator input_iterator_tag insert_iterator istream_iterator istream_iterator istreambuf_iterator istringstream iterator iterator_traits
syn keyword cppSTLtype   list
syn keyword cppSTLtype   map multimap multiset
syn keyword cppSTLtype   ofstream ostream ostream_iterator ostream_iterator ostringstream output_iterator output_iterator_tag
syn keyword cppSTLtype   pair pointer pointer_to_binary_function pointer_to_unary_function priority_queue queue
syn keyword cppSTLtype   random_access_iterator random_access_iterator_tag raw_storage_iterator reverse_bidirectional_iterator reverse_iterator reverse_iterator rope
syn keyword cppSTLtype   sequence_buffer set stack stream string
syn keyword cppSTLtype   temporary_buffer
syn keyword cppSTLtype   unary_compose unary_function unary_negate
syn keyword cppSTLtype   vector

syn keyword cppSTLType   mutex timed_mutex unique_lock lock_guard condition_variable thread milliseconds seconds 


" Default highlighting
if version >= 508 || !exists("did_cpp_syntax_inits")
  if version < 508
    let did_cpp_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif
  HiLink cppSTL				Identifier
  HiLink cppSTLtype         Type
  delcommand HiLink
endif

