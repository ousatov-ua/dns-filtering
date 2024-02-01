#!/bin/bash
ss -ntlp 'sport = :443'
ss -ntlp 'sport = :53'
ss -ntlp 'sport = :5353'
