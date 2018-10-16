%include "io.inc"

section .data
    %include "input.inc"
    
    
    
section .text
global CMAIN
CMAIN:
    mov ebp, esp
    xor eax, eax
    mov ecx,0  ; incep contorizarea de la 0
repeta:
    mov eax, dword [nums_array +4*(ecx)]  ;pun numerele in registrul eax si bazele in ebx
    mov ebx, dword [base_array +4*(ecx)]  
    inc ecx                               ; incrementez dupa fiecare citire
    cmp ecx,[nums]  ; cat timp mai sunt elemente sare la eticheta
    jle calcul
    ret 
calcul:
    cmp ebx,2    ; verific daca baza e valabila
    jl print2
    cmp ebx,16
    jg print2
    mov edx, 0  
    div ebx     ; impart la baza respectiva pt a obtine restul si catul
    cmp edx,9   ; daca restul e mai mare ca 9 convertesc la litera corespunzatoare
    jg convert
    add edx, '0' ; transform in caracter cifra
    push edx     ; pun restul pe stiva
    cmp eax,0    ; repeta cat timp nu e 0 catul
    jne calcul
    jmp print   ; afisez dupa ce se termina numarul de convertit
convert:
      add edx,0x57 ; adaug codul ascii aferent literei corespunzatoare
      push edx
      cmp eax,0
      jne calcul
      jmp print 
print:
    pop edx   ; scot de pe stiva restul
    PRINT_CHAR edx ;afisez ca si caracter
    cmp ebp,esp ; repet cat timp mai sunt elemente pe stiva
    jne print
    NEWLINE
    jmp repeta
print2:
        PRINT_STRING "Baza incorecta"  ; afisez mesaj cand baza nu e valabila
        NEWLINE 
        cmp ecx,[nums]
        jle repeta 
ret