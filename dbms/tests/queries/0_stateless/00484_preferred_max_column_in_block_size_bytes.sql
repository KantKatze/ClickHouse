drop table if exists test.tab;
create table test.tab (date Date, x UInt64, s FixedString(128)) engine = MergeTree(date, (date, x), 8192);
insert into test.tab select today(), number, toFixedString('', 128) from system.numbers limit 8192;
set preferred_block_size_bytes = 2000000;
set preferred_max_column_in_block_size_bytes = 0;
select max(blockSize()), min(blockSize()), any(ignore(*)) from test.tab;
set preferred_max_column_in_block_size_bytes = 128;
select max(blockSize()), min(blockSize()), any(ignore(*)) from test.tab;
set preferred_max_column_in_block_size_bytes = 256;
select max(blockSize()), min(blockSize()), any(ignore(*)) from test.tab;
set preferred_max_column_in_block_size_bytes = 2097152;
select max(blockSize()), min(blockSize()), any(ignore(*)) from test.tab;
set preferred_max_column_in_block_size_bytes = 4194304;
select max(blockSize()), min(blockSize()), any(ignore(*)) from test.tab;