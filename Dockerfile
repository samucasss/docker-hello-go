#-----Primeiro estagio: gerar o binario-----

#imagem base mais leve para golang
FROM golang:alpine3.20 AS builder

#define o diretorio de trabalho
WORKDIR /app

#habilita dependencia
RUN go mod init example/hello

#copia o codigo fonte
COPY . .

#gera o binario
RUN go build -o docker-hello-go hello/hello.go


#-----segundo estagio: gerar a imagem que executa o binario
#imagem base mais leve para executar binarios
FROM scratch

#define o diretorio de trabalho
WORKDIR /app

#copia o binario gerado no primeiro estagio
COPY --from=builder /app/docker-hello-go .

#executa o binario
CMD ["./docker-hello-go"]

