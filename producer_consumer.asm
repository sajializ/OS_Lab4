
_producer_consumer:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  }
}

int
main(int argc, char *argv[])
{
   0:	f3 0f 1e fb          	endbr32 
   4:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   8:	83 e4 f0             	and    $0xfffffff0,%esp
   b:	ff 71 fc             	pushl  -0x4(%ecx)
   e:	55                   	push   %ebp
   f:	89 e5                	mov    %esp,%ebp
  11:	51                   	push   %ecx
  12:	83 ec 08             	sub    $0x8,%esp
  //   consumer();

  // wait();
  // exit();

  semaphore_initialize(1,1,0);
  15:	6a 00                	push   $0x0
  17:	6a 01                	push   $0x1
  19:	6a 01                	push   $0x1
  1b:	e8 33 04 00 00       	call   453 <semaphore_initialize>
  fork();
  20:	e8 86 03 00 00       	call   3ab <fork>
  fork();
  25:	e8 81 03 00 00       	call   3ab <fork>
  semaphore_aquire(1);
  2a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  31:	e8 25 04 00 00       	call   45b <semaphore_aquire>
  printf(2, "salaaaaaaaaaam\n");
  36:	58                   	pop    %eax
  37:	5a                   	pop    %edx
  38:	68 06 09 00 00       	push   $0x906
  3d:	6a 02                	push   $0x2
  3f:	e8 fc 04 00 00       	call   540 <printf>
  sleep(100);
  44:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
  4b:	e8 f3 03 00 00       	call   443 <sleep>
  semaphore_release(1);
  50:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  57:	e8 07 04 00 00       	call   463 <semaphore_release>
  wait();
  5c:	e8 5a 03 00 00       	call   3bb <wait>
  wait();  
  61:	e8 55 03 00 00       	call   3bb <wait>
  exit();
  66:	e8 48 03 00 00       	call   3b3 <exit>
  6b:	66 90                	xchg   %ax,%ax
  6d:	66 90                	xchg   %ax,%ax
  6f:	90                   	nop

00000070 <producer>:
{
  70:	f3 0f 1e fb          	endbr32 
  74:	55                   	push   %ebp
  75:	89 e5                	mov    %esp,%ebp
  77:	83 ec 08             	sub    $0x8,%esp
  7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    semaphore_aquire(1);
  80:	83 ec 0c             	sub    $0xc,%esp
  83:	6a 01                	push   $0x1
  85:	e8 d1 03 00 00       	call   45b <semaphore_aquire>
    printf(2, "Producer aquired lock\n");
  8a:	58                   	pop    %eax
  8b:	5a                   	pop    %edx
  8c:	68 a8 08 00 00       	push   $0x8a8
  91:	6a 02                	push   $0x2
  93:	e8 a8 04 00 00       	call   540 <printf>
    while (get_counter() == BUFFER_SIZE)
  98:	83 c4 10             	add    $0x10,%esp
  9b:	e8 e3 03 00 00       	call   483 <get_counter>
  a0:	83 f8 05             	cmp    $0x5,%eax
  a3:	74 f6                	je     9b <producer+0x2b>
    inc_counter();
  a5:	e8 c1 03 00 00       	call   46b <inc_counter>
    printf(2, "Producer released lock\n");
  aa:	83 ec 08             	sub    $0x8,%esp
  ad:	68 bf 08 00 00       	push   $0x8bf
  b2:	6a 02                	push   $0x2
  b4:	e8 87 04 00 00       	call   540 <printf>
    semaphore_release(1);
  b9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  c0:	e8 9e 03 00 00       	call   463 <semaphore_release>
    sleep(500);
  c5:	c7 04 24 f4 01 00 00 	movl   $0x1f4,(%esp)
  cc:	e8 72 03 00 00       	call   443 <sleep>
    semaphore_aquire(1);
  d1:	83 c4 10             	add    $0x10,%esp
  d4:	eb aa                	jmp    80 <producer+0x10>
  d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  dd:	8d 76 00             	lea    0x0(%esi),%esi

000000e0 <consumer>:
{
  e0:	f3 0f 1e fb          	endbr32 
  e4:	55                   	push   %ebp
  e5:	89 e5                	mov    %esp,%ebp
  e7:	83 ec 08             	sub    $0x8,%esp
  ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    semaphore_aquire(1);
  f0:	83 ec 0c             	sub    $0xc,%esp
  f3:	6a 01                	push   $0x1
  f5:	e8 61 03 00 00       	call   45b <semaphore_aquire>
    printf(2, "Consumer aquired lock\n");
  fa:	58                   	pop    %eax
  fb:	5a                   	pop    %edx
  fc:	68 d7 08 00 00       	push   $0x8d7
 101:	6a 02                	push   $0x2
 103:	e8 38 04 00 00       	call   540 <printf>
    while (get_counter() == 0)
 108:	83 c4 10             	add    $0x10,%esp
 10b:	e8 73 03 00 00       	call   483 <get_counter>
 110:	85 c0                	test   %eax,%eax
 112:	74 f7                	je     10b <consumer+0x2b>
    dec_counter();
 114:	e8 5a 03 00 00       	call   473 <dec_counter>
    printf(2, "Consumer released lock\n");
 119:	83 ec 08             	sub    $0x8,%esp
 11c:	68 ee 08 00 00       	push   $0x8ee
 121:	6a 02                	push   $0x2
 123:	e8 18 04 00 00       	call   540 <printf>
    semaphore_release(1);
 128:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 12f:	e8 2f 03 00 00       	call   463 <semaphore_release>
    sleep(500);
 134:	c7 04 24 f4 01 00 00 	movl   $0x1f4,(%esp)
 13b:	e8 03 03 00 00       	call   443 <sleep>
    semaphore_aquire(1);
 140:	83 c4 10             	add    $0x10,%esp
 143:	eb ab                	jmp    f0 <consumer+0x10>
 145:	66 90                	xchg   %ax,%ax
 147:	66 90                	xchg   %ax,%ax
 149:	66 90                	xchg   %ax,%ax
 14b:	66 90                	xchg   %ax,%ax
 14d:	66 90                	xchg   %ax,%ax
 14f:	90                   	nop

00000150 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 150:	f3 0f 1e fb          	endbr32 
 154:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 155:	31 c0                	xor    %eax,%eax
{
 157:	89 e5                	mov    %esp,%ebp
 159:	53                   	push   %ebx
 15a:	8b 4d 08             	mov    0x8(%ebp),%ecx
 15d:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while((*s++ = *t++) != 0)
 160:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 164:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 167:	83 c0 01             	add    $0x1,%eax
 16a:	84 d2                	test   %dl,%dl
 16c:	75 f2                	jne    160 <strcpy+0x10>
    ;
  return os;
}
 16e:	89 c8                	mov    %ecx,%eax
 170:	5b                   	pop    %ebx
 171:	5d                   	pop    %ebp
 172:	c3                   	ret    
 173:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 17a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000180 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 180:	f3 0f 1e fb          	endbr32 
 184:	55                   	push   %ebp
 185:	89 e5                	mov    %esp,%ebp
 187:	53                   	push   %ebx
 188:	8b 4d 08             	mov    0x8(%ebp),%ecx
 18b:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 18e:	0f b6 01             	movzbl (%ecx),%eax
 191:	0f b6 1a             	movzbl (%edx),%ebx
 194:	84 c0                	test   %al,%al
 196:	75 19                	jne    1b1 <strcmp+0x31>
 198:	eb 26                	jmp    1c0 <strcmp+0x40>
 19a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1a0:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
 1a4:	83 c1 01             	add    $0x1,%ecx
 1a7:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 1aa:	0f b6 1a             	movzbl (%edx),%ebx
 1ad:	84 c0                	test   %al,%al
 1af:	74 0f                	je     1c0 <strcmp+0x40>
 1b1:	38 d8                	cmp    %bl,%al
 1b3:	74 eb                	je     1a0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 1b5:	29 d8                	sub    %ebx,%eax
}
 1b7:	5b                   	pop    %ebx
 1b8:	5d                   	pop    %ebp
 1b9:	c3                   	ret    
 1ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1c0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 1c2:	29 d8                	sub    %ebx,%eax
}
 1c4:	5b                   	pop    %ebx
 1c5:	5d                   	pop    %ebp
 1c6:	c3                   	ret    
 1c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1ce:	66 90                	xchg   %ax,%ax

000001d0 <strlen>:

uint
strlen(const char *s)
{
 1d0:	f3 0f 1e fb          	endbr32 
 1d4:	55                   	push   %ebp
 1d5:	89 e5                	mov    %esp,%ebp
 1d7:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 1da:	80 3a 00             	cmpb   $0x0,(%edx)
 1dd:	74 21                	je     200 <strlen+0x30>
 1df:	31 c0                	xor    %eax,%eax
 1e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1e8:	83 c0 01             	add    $0x1,%eax
 1eb:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 1ef:	89 c1                	mov    %eax,%ecx
 1f1:	75 f5                	jne    1e8 <strlen+0x18>
    ;
  return n;
}
 1f3:	89 c8                	mov    %ecx,%eax
 1f5:	5d                   	pop    %ebp
 1f6:	c3                   	ret    
 1f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1fe:	66 90                	xchg   %ax,%ax
  for(n = 0; s[n]; n++)
 200:	31 c9                	xor    %ecx,%ecx
}
 202:	5d                   	pop    %ebp
 203:	89 c8                	mov    %ecx,%eax
 205:	c3                   	ret    
 206:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 20d:	8d 76 00             	lea    0x0(%esi),%esi

00000210 <memset>:

void*
memset(void *dst, int c, uint n)
{
 210:	f3 0f 1e fb          	endbr32 
 214:	55                   	push   %ebp
 215:	89 e5                	mov    %esp,%ebp
 217:	57                   	push   %edi
 218:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 21b:	8b 4d 10             	mov    0x10(%ebp),%ecx
 21e:	8b 45 0c             	mov    0xc(%ebp),%eax
 221:	89 d7                	mov    %edx,%edi
 223:	fc                   	cld    
 224:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 226:	89 d0                	mov    %edx,%eax
 228:	5f                   	pop    %edi
 229:	5d                   	pop    %ebp
 22a:	c3                   	ret    
 22b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 22f:	90                   	nop

00000230 <strchr>:

char*
strchr(const char *s, char c)
{
 230:	f3 0f 1e fb          	endbr32 
 234:	55                   	push   %ebp
 235:	89 e5                	mov    %esp,%ebp
 237:	8b 45 08             	mov    0x8(%ebp),%eax
 23a:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 23e:	0f b6 10             	movzbl (%eax),%edx
 241:	84 d2                	test   %dl,%dl
 243:	75 16                	jne    25b <strchr+0x2b>
 245:	eb 21                	jmp    268 <strchr+0x38>
 247:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 24e:	66 90                	xchg   %ax,%ax
 250:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 254:	83 c0 01             	add    $0x1,%eax
 257:	84 d2                	test   %dl,%dl
 259:	74 0d                	je     268 <strchr+0x38>
    if(*s == c)
 25b:	38 d1                	cmp    %dl,%cl
 25d:	75 f1                	jne    250 <strchr+0x20>
      return (char*)s;
  return 0;
}
 25f:	5d                   	pop    %ebp
 260:	c3                   	ret    
 261:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 268:	31 c0                	xor    %eax,%eax
}
 26a:	5d                   	pop    %ebp
 26b:	c3                   	ret    
 26c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000270 <gets>:

char*
gets(char *buf, int max)
{
 270:	f3 0f 1e fb          	endbr32 
 274:	55                   	push   %ebp
 275:	89 e5                	mov    %esp,%ebp
 277:	57                   	push   %edi
 278:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 279:	31 f6                	xor    %esi,%esi
{
 27b:	53                   	push   %ebx
 27c:	89 f3                	mov    %esi,%ebx
 27e:	83 ec 1c             	sub    $0x1c,%esp
 281:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 284:	eb 33                	jmp    2b9 <gets+0x49>
 286:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 28d:	8d 76 00             	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 290:	83 ec 04             	sub    $0x4,%esp
 293:	8d 45 e7             	lea    -0x19(%ebp),%eax
 296:	6a 01                	push   $0x1
 298:	50                   	push   %eax
 299:	6a 00                	push   $0x0
 29b:	e8 2b 01 00 00       	call   3cb <read>
    if(cc < 1)
 2a0:	83 c4 10             	add    $0x10,%esp
 2a3:	85 c0                	test   %eax,%eax
 2a5:	7e 1c                	jle    2c3 <gets+0x53>
      break;
    buf[i++] = c;
 2a7:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 2ab:	83 c7 01             	add    $0x1,%edi
 2ae:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 2b1:	3c 0a                	cmp    $0xa,%al
 2b3:	74 23                	je     2d8 <gets+0x68>
 2b5:	3c 0d                	cmp    $0xd,%al
 2b7:	74 1f                	je     2d8 <gets+0x68>
  for(i=0; i+1 < max; ){
 2b9:	83 c3 01             	add    $0x1,%ebx
 2bc:	89 fe                	mov    %edi,%esi
 2be:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 2c1:	7c cd                	jl     290 <gets+0x20>
 2c3:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 2c5:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 2c8:	c6 03 00             	movb   $0x0,(%ebx)
}
 2cb:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2ce:	5b                   	pop    %ebx
 2cf:	5e                   	pop    %esi
 2d0:	5f                   	pop    %edi
 2d1:	5d                   	pop    %ebp
 2d2:	c3                   	ret    
 2d3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2d7:	90                   	nop
 2d8:	8b 75 08             	mov    0x8(%ebp),%esi
 2db:	8b 45 08             	mov    0x8(%ebp),%eax
 2de:	01 de                	add    %ebx,%esi
 2e0:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 2e2:	c6 03 00             	movb   $0x0,(%ebx)
}
 2e5:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2e8:	5b                   	pop    %ebx
 2e9:	5e                   	pop    %esi
 2ea:	5f                   	pop    %edi
 2eb:	5d                   	pop    %ebp
 2ec:	c3                   	ret    
 2ed:	8d 76 00             	lea    0x0(%esi),%esi

000002f0 <stat>:

int
stat(const char *n, struct stat *st)
{
 2f0:	f3 0f 1e fb          	endbr32 
 2f4:	55                   	push   %ebp
 2f5:	89 e5                	mov    %esp,%ebp
 2f7:	56                   	push   %esi
 2f8:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2f9:	83 ec 08             	sub    $0x8,%esp
 2fc:	6a 00                	push   $0x0
 2fe:	ff 75 08             	pushl  0x8(%ebp)
 301:	e8 ed 00 00 00       	call   3f3 <open>
  if(fd < 0)
 306:	83 c4 10             	add    $0x10,%esp
 309:	85 c0                	test   %eax,%eax
 30b:	78 2b                	js     338 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 30d:	83 ec 08             	sub    $0x8,%esp
 310:	ff 75 0c             	pushl  0xc(%ebp)
 313:	89 c3                	mov    %eax,%ebx
 315:	50                   	push   %eax
 316:	e8 f0 00 00 00       	call   40b <fstat>
  close(fd);
 31b:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 31e:	89 c6                	mov    %eax,%esi
  close(fd);
 320:	e8 b6 00 00 00       	call   3db <close>
  return r;
 325:	83 c4 10             	add    $0x10,%esp
}
 328:	8d 65 f8             	lea    -0x8(%ebp),%esp
 32b:	89 f0                	mov    %esi,%eax
 32d:	5b                   	pop    %ebx
 32e:	5e                   	pop    %esi
 32f:	5d                   	pop    %ebp
 330:	c3                   	ret    
 331:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 338:	be ff ff ff ff       	mov    $0xffffffff,%esi
 33d:	eb e9                	jmp    328 <stat+0x38>
 33f:	90                   	nop

00000340 <atoi>:

int
atoi(const char *s)
{
 340:	f3 0f 1e fb          	endbr32 
 344:	55                   	push   %ebp
 345:	89 e5                	mov    %esp,%ebp
 347:	53                   	push   %ebx
 348:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 34b:	0f be 02             	movsbl (%edx),%eax
 34e:	8d 48 d0             	lea    -0x30(%eax),%ecx
 351:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 354:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 359:	77 1a                	ja     375 <atoi+0x35>
 35b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 35f:	90                   	nop
    n = n*10 + *s++ - '0';
 360:	83 c2 01             	add    $0x1,%edx
 363:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 366:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 36a:	0f be 02             	movsbl (%edx),%eax
 36d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 370:	80 fb 09             	cmp    $0x9,%bl
 373:	76 eb                	jbe    360 <atoi+0x20>
  return n;
}
 375:	89 c8                	mov    %ecx,%eax
 377:	5b                   	pop    %ebx
 378:	5d                   	pop    %ebp
 379:	c3                   	ret    
 37a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000380 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 380:	f3 0f 1e fb          	endbr32 
 384:	55                   	push   %ebp
 385:	89 e5                	mov    %esp,%ebp
 387:	57                   	push   %edi
 388:	8b 45 10             	mov    0x10(%ebp),%eax
 38b:	8b 55 08             	mov    0x8(%ebp),%edx
 38e:	56                   	push   %esi
 38f:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 392:	85 c0                	test   %eax,%eax
 394:	7e 0f                	jle    3a5 <memmove+0x25>
 396:	01 d0                	add    %edx,%eax
  dst = vdst;
 398:	89 d7                	mov    %edx,%edi
 39a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    *dst++ = *src++;
 3a0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 3a1:	39 f8                	cmp    %edi,%eax
 3a3:	75 fb                	jne    3a0 <memmove+0x20>
  return vdst;
}
 3a5:	5e                   	pop    %esi
 3a6:	89 d0                	mov    %edx,%eax
 3a8:	5f                   	pop    %edi
 3a9:	5d                   	pop    %ebp
 3aa:	c3                   	ret    

000003ab <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3ab:	b8 01 00 00 00       	mov    $0x1,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret    

000003b3 <exit>:
SYSCALL(exit)
 3b3:	b8 02 00 00 00       	mov    $0x2,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret    

000003bb <wait>:
SYSCALL(wait)
 3bb:	b8 03 00 00 00       	mov    $0x3,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret    

000003c3 <pipe>:
SYSCALL(pipe)
 3c3:	b8 04 00 00 00       	mov    $0x4,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret    

000003cb <read>:
SYSCALL(read)
 3cb:	b8 05 00 00 00       	mov    $0x5,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret    

000003d3 <write>:
SYSCALL(write)
 3d3:	b8 10 00 00 00       	mov    $0x10,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret    

000003db <close>:
SYSCALL(close)
 3db:	b8 15 00 00 00       	mov    $0x15,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret    

000003e3 <kill>:
SYSCALL(kill)
 3e3:	b8 06 00 00 00       	mov    $0x6,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret    

000003eb <exec>:
SYSCALL(exec)
 3eb:	b8 07 00 00 00       	mov    $0x7,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret    

000003f3 <open>:
SYSCALL(open)
 3f3:	b8 0f 00 00 00       	mov    $0xf,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret    

000003fb <mknod>:
SYSCALL(mknod)
 3fb:	b8 11 00 00 00       	mov    $0x11,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret    

00000403 <unlink>:
SYSCALL(unlink)
 403:	b8 12 00 00 00       	mov    $0x12,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret    

0000040b <fstat>:
SYSCALL(fstat)
 40b:	b8 08 00 00 00       	mov    $0x8,%eax
 410:	cd 40                	int    $0x40
 412:	c3                   	ret    

00000413 <link>:
SYSCALL(link)
 413:	b8 13 00 00 00       	mov    $0x13,%eax
 418:	cd 40                	int    $0x40
 41a:	c3                   	ret    

0000041b <mkdir>:
SYSCALL(mkdir)
 41b:	b8 14 00 00 00       	mov    $0x14,%eax
 420:	cd 40                	int    $0x40
 422:	c3                   	ret    

00000423 <chdir>:
SYSCALL(chdir)
 423:	b8 09 00 00 00       	mov    $0x9,%eax
 428:	cd 40                	int    $0x40
 42a:	c3                   	ret    

0000042b <dup>:
SYSCALL(dup)
 42b:	b8 0a 00 00 00       	mov    $0xa,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret    

00000433 <getpid>:
SYSCALL(getpid)
 433:	b8 0b 00 00 00       	mov    $0xb,%eax
 438:	cd 40                	int    $0x40
 43a:	c3                   	ret    

0000043b <sbrk>:
SYSCALL(sbrk)
 43b:	b8 0c 00 00 00       	mov    $0xc,%eax
 440:	cd 40                	int    $0x40
 442:	c3                   	ret    

00000443 <sleep>:
SYSCALL(sleep)
 443:	b8 0d 00 00 00       	mov    $0xd,%eax
 448:	cd 40                	int    $0x40
 44a:	c3                   	ret    

0000044b <uptime>:
SYSCALL(uptime)
 44b:	b8 0e 00 00 00       	mov    $0xe,%eax
 450:	cd 40                	int    $0x40
 452:	c3                   	ret    

00000453 <semaphore_initialize>:
SYSCALL(semaphore_initialize)
 453:	b8 16 00 00 00       	mov    $0x16,%eax
 458:	cd 40                	int    $0x40
 45a:	c3                   	ret    

0000045b <semaphore_aquire>:
SYSCALL(semaphore_aquire)
 45b:	b8 17 00 00 00       	mov    $0x17,%eax
 460:	cd 40                	int    $0x40
 462:	c3                   	ret    

00000463 <semaphore_release>:
SYSCALL(semaphore_release)
 463:	b8 18 00 00 00       	mov    $0x18,%eax
 468:	cd 40                	int    $0x40
 46a:	c3                   	ret    

0000046b <inc_counter>:
SYSCALL(inc_counter)
 46b:	b8 28 00 00 00       	mov    $0x28,%eax
 470:	cd 40                	int    $0x40
 472:	c3                   	ret    

00000473 <dec_counter>:
SYSCALL(dec_counter)
 473:	b8 29 00 00 00       	mov    $0x29,%eax
 478:	cd 40                	int    $0x40
 47a:	c3                   	ret    

0000047b <reset_counter>:
SYSCALL(reset_counter)
 47b:	b8 2a 00 00 00       	mov    $0x2a,%eax
 480:	cd 40                	int    $0x40
 482:	c3                   	ret    

00000483 <get_counter>:
 483:	b8 2b 00 00 00       	mov    $0x2b,%eax
 488:	cd 40                	int    $0x40
 48a:	c3                   	ret    
 48b:	66 90                	xchg   %ax,%ax
 48d:	66 90                	xchg   %ax,%ax
 48f:	90                   	nop

00000490 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 490:	55                   	push   %ebp
 491:	89 e5                	mov    %esp,%ebp
 493:	57                   	push   %edi
 494:	56                   	push   %esi
 495:	53                   	push   %ebx
 496:	83 ec 3c             	sub    $0x3c,%esp
 499:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 49c:	89 d1                	mov    %edx,%ecx
{
 49e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 4a1:	85 d2                	test   %edx,%edx
 4a3:	0f 89 7f 00 00 00    	jns    528 <printint+0x98>
 4a9:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 4ad:	74 79                	je     528 <printint+0x98>
    neg = 1;
 4af:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 4b6:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 4b8:	31 db                	xor    %ebx,%ebx
 4ba:	8d 75 d7             	lea    -0x29(%ebp),%esi
 4bd:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 4c0:	89 c8                	mov    %ecx,%eax
 4c2:	31 d2                	xor    %edx,%edx
 4c4:	89 cf                	mov    %ecx,%edi
 4c6:	f7 75 c4             	divl   -0x3c(%ebp)
 4c9:	0f b6 92 20 09 00 00 	movzbl 0x920(%edx),%edx
 4d0:	89 45 c0             	mov    %eax,-0x40(%ebp)
 4d3:	89 d8                	mov    %ebx,%eax
 4d5:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 4d8:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 4db:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 4de:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 4e1:	76 dd                	jbe    4c0 <printint+0x30>
  if(neg)
 4e3:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 4e6:	85 c9                	test   %ecx,%ecx
 4e8:	74 0c                	je     4f6 <printint+0x66>
    buf[i++] = '-';
 4ea:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 4ef:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 4f1:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 4f6:	8b 7d b8             	mov    -0x48(%ebp),%edi
 4f9:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 4fd:	eb 07                	jmp    506 <printint+0x76>
 4ff:	90                   	nop
 500:	0f b6 13             	movzbl (%ebx),%edx
 503:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 506:	83 ec 04             	sub    $0x4,%esp
 509:	88 55 d7             	mov    %dl,-0x29(%ebp)
 50c:	6a 01                	push   $0x1
 50e:	56                   	push   %esi
 50f:	57                   	push   %edi
 510:	e8 be fe ff ff       	call   3d3 <write>
  while(--i >= 0)
 515:	83 c4 10             	add    $0x10,%esp
 518:	39 de                	cmp    %ebx,%esi
 51a:	75 e4                	jne    500 <printint+0x70>
    putc(fd, buf[i]);
}
 51c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 51f:	5b                   	pop    %ebx
 520:	5e                   	pop    %esi
 521:	5f                   	pop    %edi
 522:	5d                   	pop    %ebp
 523:	c3                   	ret    
 524:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 528:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 52f:	eb 87                	jmp    4b8 <printint+0x28>
 531:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 538:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 53f:	90                   	nop

00000540 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 540:	f3 0f 1e fb          	endbr32 
 544:	55                   	push   %ebp
 545:	89 e5                	mov    %esp,%ebp
 547:	57                   	push   %edi
 548:	56                   	push   %esi
 549:	53                   	push   %ebx
 54a:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 54d:	8b 75 0c             	mov    0xc(%ebp),%esi
 550:	0f b6 1e             	movzbl (%esi),%ebx
 553:	84 db                	test   %bl,%bl
 555:	0f 84 b4 00 00 00    	je     60f <printf+0xcf>
  ap = (uint*)(void*)&fmt + 1;
 55b:	8d 45 10             	lea    0x10(%ebp),%eax
 55e:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 561:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 564:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
 566:	89 45 d0             	mov    %eax,-0x30(%ebp)
 569:	eb 33                	jmp    59e <printf+0x5e>
 56b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 56f:	90                   	nop
 570:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 573:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 578:	83 f8 25             	cmp    $0x25,%eax
 57b:	74 17                	je     594 <printf+0x54>
  write(fd, &c, 1);
 57d:	83 ec 04             	sub    $0x4,%esp
 580:	88 5d e7             	mov    %bl,-0x19(%ebp)
 583:	6a 01                	push   $0x1
 585:	57                   	push   %edi
 586:	ff 75 08             	pushl  0x8(%ebp)
 589:	e8 45 fe ff ff       	call   3d3 <write>
 58e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 591:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 594:	0f b6 1e             	movzbl (%esi),%ebx
 597:	83 c6 01             	add    $0x1,%esi
 59a:	84 db                	test   %bl,%bl
 59c:	74 71                	je     60f <printf+0xcf>
    c = fmt[i] & 0xff;
 59e:	0f be cb             	movsbl %bl,%ecx
 5a1:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 5a4:	85 d2                	test   %edx,%edx
 5a6:	74 c8                	je     570 <printf+0x30>
      }
    } else if(state == '%'){
 5a8:	83 fa 25             	cmp    $0x25,%edx
 5ab:	75 e7                	jne    594 <printf+0x54>
      if(c == 'd'){
 5ad:	83 f8 64             	cmp    $0x64,%eax
 5b0:	0f 84 9a 00 00 00    	je     650 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 5b6:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 5bc:	83 f9 70             	cmp    $0x70,%ecx
 5bf:	74 5f                	je     620 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 5c1:	83 f8 73             	cmp    $0x73,%eax
 5c4:	0f 84 d6 00 00 00    	je     6a0 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5ca:	83 f8 63             	cmp    $0x63,%eax
 5cd:	0f 84 8d 00 00 00    	je     660 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 5d3:	83 f8 25             	cmp    $0x25,%eax
 5d6:	0f 84 b4 00 00 00    	je     690 <printf+0x150>
  write(fd, &c, 1);
 5dc:	83 ec 04             	sub    $0x4,%esp
 5df:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 5e3:	6a 01                	push   $0x1
 5e5:	57                   	push   %edi
 5e6:	ff 75 08             	pushl  0x8(%ebp)
 5e9:	e8 e5 fd ff ff       	call   3d3 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 5ee:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 5f1:	83 c4 0c             	add    $0xc,%esp
 5f4:	6a 01                	push   $0x1
 5f6:	83 c6 01             	add    $0x1,%esi
 5f9:	57                   	push   %edi
 5fa:	ff 75 08             	pushl  0x8(%ebp)
 5fd:	e8 d1 fd ff ff       	call   3d3 <write>
  for(i = 0; fmt[i]; i++){
 602:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
 606:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 609:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 60b:	84 db                	test   %bl,%bl
 60d:	75 8f                	jne    59e <printf+0x5e>
    }
  }
}
 60f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 612:	5b                   	pop    %ebx
 613:	5e                   	pop    %esi
 614:	5f                   	pop    %edi
 615:	5d                   	pop    %ebp
 616:	c3                   	ret    
 617:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 61e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 620:	83 ec 0c             	sub    $0xc,%esp
 623:	b9 10 00 00 00       	mov    $0x10,%ecx
 628:	6a 00                	push   $0x0
 62a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 62d:	8b 45 08             	mov    0x8(%ebp),%eax
 630:	8b 13                	mov    (%ebx),%edx
 632:	e8 59 fe ff ff       	call   490 <printint>
        ap++;
 637:	89 d8                	mov    %ebx,%eax
 639:	83 c4 10             	add    $0x10,%esp
      state = 0;
 63c:	31 d2                	xor    %edx,%edx
        ap++;
 63e:	83 c0 04             	add    $0x4,%eax
 641:	89 45 d0             	mov    %eax,-0x30(%ebp)
 644:	e9 4b ff ff ff       	jmp    594 <printf+0x54>
 649:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 650:	83 ec 0c             	sub    $0xc,%esp
 653:	b9 0a 00 00 00       	mov    $0xa,%ecx
 658:	6a 01                	push   $0x1
 65a:	eb ce                	jmp    62a <printf+0xea>
 65c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 660:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 663:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 666:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
 668:	6a 01                	push   $0x1
        ap++;
 66a:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 66d:	57                   	push   %edi
 66e:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
 671:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 674:	e8 5a fd ff ff       	call   3d3 <write>
        ap++;
 679:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 67c:	83 c4 10             	add    $0x10,%esp
      state = 0;
 67f:	31 d2                	xor    %edx,%edx
 681:	e9 0e ff ff ff       	jmp    594 <printf+0x54>
 686:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 68d:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
 690:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 693:	83 ec 04             	sub    $0x4,%esp
 696:	e9 59 ff ff ff       	jmp    5f4 <printf+0xb4>
 69b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 69f:	90                   	nop
        s = (char*)*ap;
 6a0:	8b 45 d0             	mov    -0x30(%ebp),%eax
 6a3:	8b 18                	mov    (%eax),%ebx
        ap++;
 6a5:	83 c0 04             	add    $0x4,%eax
 6a8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 6ab:	85 db                	test   %ebx,%ebx
 6ad:	74 17                	je     6c6 <printf+0x186>
        while(*s != 0){
 6af:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 6b2:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 6b4:	84 c0                	test   %al,%al
 6b6:	0f 84 d8 fe ff ff    	je     594 <printf+0x54>
 6bc:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 6bf:	89 de                	mov    %ebx,%esi
 6c1:	8b 5d 08             	mov    0x8(%ebp),%ebx
 6c4:	eb 1a                	jmp    6e0 <printf+0x1a0>
          s = "(null)";
 6c6:	bb 16 09 00 00       	mov    $0x916,%ebx
        while(*s != 0){
 6cb:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 6ce:	b8 28 00 00 00       	mov    $0x28,%eax
 6d3:	89 de                	mov    %ebx,%esi
 6d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
 6d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6df:	90                   	nop
  write(fd, &c, 1);
 6e0:	83 ec 04             	sub    $0x4,%esp
          s++;
 6e3:	83 c6 01             	add    $0x1,%esi
 6e6:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 6e9:	6a 01                	push   $0x1
 6eb:	57                   	push   %edi
 6ec:	53                   	push   %ebx
 6ed:	e8 e1 fc ff ff       	call   3d3 <write>
        while(*s != 0){
 6f2:	0f b6 06             	movzbl (%esi),%eax
 6f5:	83 c4 10             	add    $0x10,%esp
 6f8:	84 c0                	test   %al,%al
 6fa:	75 e4                	jne    6e0 <printf+0x1a0>
 6fc:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
 6ff:	31 d2                	xor    %edx,%edx
 701:	e9 8e fe ff ff       	jmp    594 <printf+0x54>
 706:	66 90                	xchg   %ax,%ax
 708:	66 90                	xchg   %ax,%ax
 70a:	66 90                	xchg   %ax,%ax
 70c:	66 90                	xchg   %ax,%ax
 70e:	66 90                	xchg   %ax,%ax

00000710 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 710:	f3 0f 1e fb          	endbr32 
 714:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 715:	a1 00 0c 00 00       	mov    0xc00,%eax
{
 71a:	89 e5                	mov    %esp,%ebp
 71c:	57                   	push   %edi
 71d:	56                   	push   %esi
 71e:	53                   	push   %ebx
 71f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 722:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
 724:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 727:	39 c8                	cmp    %ecx,%eax
 729:	73 15                	jae    740 <free+0x30>
 72b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 72f:	90                   	nop
 730:	39 d1                	cmp    %edx,%ecx
 732:	72 14                	jb     748 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 734:	39 d0                	cmp    %edx,%eax
 736:	73 10                	jae    748 <free+0x38>
{
 738:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 73a:	8b 10                	mov    (%eax),%edx
 73c:	39 c8                	cmp    %ecx,%eax
 73e:	72 f0                	jb     730 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 740:	39 d0                	cmp    %edx,%eax
 742:	72 f4                	jb     738 <free+0x28>
 744:	39 d1                	cmp    %edx,%ecx
 746:	73 f0                	jae    738 <free+0x28>
      break;
  if(bp + bp->s.size == p->s.ptr){
 748:	8b 73 fc             	mov    -0x4(%ebx),%esi
 74b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 74e:	39 fa                	cmp    %edi,%edx
 750:	74 1e                	je     770 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 752:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 755:	8b 50 04             	mov    0x4(%eax),%edx
 758:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 75b:	39 f1                	cmp    %esi,%ecx
 75d:	74 28                	je     787 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 75f:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 761:	5b                   	pop    %ebx
  freep = p;
 762:	a3 00 0c 00 00       	mov    %eax,0xc00
}
 767:	5e                   	pop    %esi
 768:	5f                   	pop    %edi
 769:	5d                   	pop    %ebp
 76a:	c3                   	ret    
 76b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 76f:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 770:	03 72 04             	add    0x4(%edx),%esi
 773:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 776:	8b 10                	mov    (%eax),%edx
 778:	8b 12                	mov    (%edx),%edx
 77a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 77d:	8b 50 04             	mov    0x4(%eax),%edx
 780:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 783:	39 f1                	cmp    %esi,%ecx
 785:	75 d8                	jne    75f <free+0x4f>
    p->s.size += bp->s.size;
 787:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 78a:	a3 00 0c 00 00       	mov    %eax,0xc00
    p->s.size += bp->s.size;
 78f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 792:	8b 53 f8             	mov    -0x8(%ebx),%edx
 795:	89 10                	mov    %edx,(%eax)
}
 797:	5b                   	pop    %ebx
 798:	5e                   	pop    %esi
 799:	5f                   	pop    %edi
 79a:	5d                   	pop    %ebp
 79b:	c3                   	ret    
 79c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000007a0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7a0:	f3 0f 1e fb          	endbr32 
 7a4:	55                   	push   %ebp
 7a5:	89 e5                	mov    %esp,%ebp
 7a7:	57                   	push   %edi
 7a8:	56                   	push   %esi
 7a9:	53                   	push   %ebx
 7aa:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7ad:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 7b0:	8b 3d 00 0c 00 00    	mov    0xc00,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7b6:	8d 70 07             	lea    0x7(%eax),%esi
 7b9:	c1 ee 03             	shr    $0x3,%esi
 7bc:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 7bf:	85 ff                	test   %edi,%edi
 7c1:	0f 84 a9 00 00 00    	je     870 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7c7:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
 7c9:	8b 48 04             	mov    0x4(%eax),%ecx
 7cc:	39 f1                	cmp    %esi,%ecx
 7ce:	73 6d                	jae    83d <malloc+0x9d>
 7d0:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 7d6:	bb 00 10 00 00       	mov    $0x1000,%ebx
 7db:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 7de:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
 7e5:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
 7e8:	eb 17                	jmp    801 <malloc+0x61>
 7ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7f0:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 7f2:	8b 4a 04             	mov    0x4(%edx),%ecx
 7f5:	39 f1                	cmp    %esi,%ecx
 7f7:	73 4f                	jae    848 <malloc+0xa8>
 7f9:	8b 3d 00 0c 00 00    	mov    0xc00,%edi
 7ff:	89 d0                	mov    %edx,%eax
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 801:	39 c7                	cmp    %eax,%edi
 803:	75 eb                	jne    7f0 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
 805:	83 ec 0c             	sub    $0xc,%esp
 808:	ff 75 e4             	pushl  -0x1c(%ebp)
 80b:	e8 2b fc ff ff       	call   43b <sbrk>
  if(p == (char*)-1)
 810:	83 c4 10             	add    $0x10,%esp
 813:	83 f8 ff             	cmp    $0xffffffff,%eax
 816:	74 1b                	je     833 <malloc+0x93>
  hp->s.size = nu;
 818:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 81b:	83 ec 0c             	sub    $0xc,%esp
 81e:	83 c0 08             	add    $0x8,%eax
 821:	50                   	push   %eax
 822:	e8 e9 fe ff ff       	call   710 <free>
  return freep;
 827:	a1 00 0c 00 00       	mov    0xc00,%eax
      if((p = morecore(nunits)) == 0)
 82c:	83 c4 10             	add    $0x10,%esp
 82f:	85 c0                	test   %eax,%eax
 831:	75 bd                	jne    7f0 <malloc+0x50>
        return 0;
  }
}
 833:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 836:	31 c0                	xor    %eax,%eax
}
 838:	5b                   	pop    %ebx
 839:	5e                   	pop    %esi
 83a:	5f                   	pop    %edi
 83b:	5d                   	pop    %ebp
 83c:	c3                   	ret    
    if(p->s.size >= nunits){
 83d:	89 c2                	mov    %eax,%edx
 83f:	89 f8                	mov    %edi,%eax
 841:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 848:	39 ce                	cmp    %ecx,%esi
 84a:	74 54                	je     8a0 <malloc+0x100>
        p->s.size -= nunits;
 84c:	29 f1                	sub    %esi,%ecx
 84e:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
 851:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
 854:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
 857:	a3 00 0c 00 00       	mov    %eax,0xc00
}
 85c:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 85f:	8d 42 08             	lea    0x8(%edx),%eax
}
 862:	5b                   	pop    %ebx
 863:	5e                   	pop    %esi
 864:	5f                   	pop    %edi
 865:	5d                   	pop    %ebp
 866:	c3                   	ret    
 867:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 86e:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
 870:	c7 05 00 0c 00 00 04 	movl   $0xc04,0xc00
 877:	0c 00 00 
    base.s.size = 0;
 87a:	bf 04 0c 00 00       	mov    $0xc04,%edi
    base.s.ptr = freep = prevp = &base;
 87f:	c7 05 04 0c 00 00 04 	movl   $0xc04,0xc04
 886:	0c 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 889:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
 88b:	c7 05 08 0c 00 00 00 	movl   $0x0,0xc08
 892:	00 00 00 
    if(p->s.size >= nunits){
 895:	e9 36 ff ff ff       	jmp    7d0 <malloc+0x30>
 89a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 8a0:	8b 0a                	mov    (%edx),%ecx
 8a2:	89 08                	mov    %ecx,(%eax)
 8a4:	eb b1                	jmp    857 <malloc+0xb7>
